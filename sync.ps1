param(
    [switch]$Link
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$skillsSrc = Join-Path $repoRoot "skills"

$allSkills = Get-ChildItem -LiteralPath $skillsSrc -Directory | Select-Object -ExpandProperty Name

# Exclude client-specific skills from Antigravity to keep prompt context focused
$antigravityExclude = @(
    'client-tests',
    'ship-readiness'
)
$antigravitySkills = $allSkills | Where-Object { $_ -notin $antigravityExclude }

function Sync-SkillSet {
    param(
        [string]$TargetDir,
        [string[]]$SkillNames
    )

    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null

    foreach ($name in $SkillNames) {
        $src = Join-Path $skillsSrc $name
        if (-not (Test-Path -LiteralPath $src)) { continue }
        $dst = Join-Path $TargetDir $name

        if (Test-Path -LiteralPath $dst) {
            $item = Get-Item -LiteralPath $dst -Force
            if ($item.LinkType) {
                [System.IO.Directory]::Delete($dst)
            } else {
                Remove-Item -LiteralPath $dst -Recurse -Force
            }
        }

        if ($Link) {
            New-Item -ItemType Junction -Path $dst -Target $src | Out-Null
        } else {
            Copy-Item -LiteralPath $src -Destination $dst -Recurse -Force
        }
    }
}

$claudeDir = Join-Path $HOME ".claude\skills"
$codexDir = Join-Path $HOME ".codex\skills"
$agyPluginDir = Join-Path $HOME ".gemini\config\plugins\claude-skills"
$agySkillsDir = Join-Path $agyPluginDir "skills"

Sync-SkillSet -TargetDir $claudeDir -SkillNames $allSkills
Sync-SkillSet -TargetDir $codexDir -SkillNames $allSkills
Sync-SkillSet -TargetDir $agySkillsDir -SkillNames $antigravitySkills

$t3AgyRoot = Join-Path $HOME ".t3\userdata\providers\antigravity"
$t3AgyTargets = @()
if (Test-Path -LiteralPath $t3AgyRoot) {
    foreach ($providerDir in (Get-ChildItem -LiteralPath $t3AgyRoot -Directory)) {
        $t3SkillsDir = Join-Path $providerDir.FullName "config\skills"
        Sync-SkillSet -TargetDir $t3SkillsDir -SkillNames $antigravitySkills
        $t3AgyTargets += $t3SkillsDir
    }
}

$pluginJsonPath = Join-Path $agyPluginDir "plugin.json"
if (-not (Test-Path -LiteralPath $pluginJsonPath)) {
    @'
{
  "name": "claude-skills",
  "displayName": "Claude Skills",
  "version": "1.0.0",
  "description": "Curated skills synced from coding-skill repo for coding, code review/validation, and explaining school projects."
}
'@ | Set-Content -LiteralPath $pluginJsonPath -Encoding UTF8
}

$geminiRulesSrc = Join-Path $repoRoot "rules\GEMINI.md"
$geminiRulesDst = Join-Path $HOME ".gemini\GEMINI.md"
if (Test-Path -LiteralPath $geminiRulesSrc) {
    New-Item -ItemType Directory -Path (Split-Path -Parent $geminiRulesDst) -Force | Out-Null
    Copy-Item -LiteralPath $geminiRulesSrc -Destination $geminiRulesDst -Force
}

$mode = if ($Link) { "linked (junctions)" } else { "copied" }
Write-Output "Done ($mode):"
Write-Output "  Claude:      $($allSkills.Count) skills -> $claudeDir"
Write-Output "  Codex:       $($allSkills.Count) skills -> $codexDir"
Write-Output "  Antigravity: $($antigravitySkills.Count) skills -> $agySkillsDir"
foreach ($t3Dir in $t3AgyTargets) {
    Write-Output "  T3 Gemini:   $($antigravitySkills.Count) skills -> $t3Dir"
}
Write-Output "  Rules:       $geminiRulesDst"
