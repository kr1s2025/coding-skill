# coding-skill

Private repository of personal coding, code review, PR workflow, and learning skills synced across PCs for **Claude**, **Codex**, and **Antigravity**.

## Included skills (15)

**Coding, PRs, and workflows**
- `file-pr`: File concise, clean pull requests.
- `frontend-design`: Build distinctive, polished web and UI interfaces.
- `full-send`: Autonomous end-to-end coding workflow to a merged PR (uses `gemini-loop`).
- `full-stop`: Autonomous coding workflow stopping at a ready-to-merge PR (uses `gemini-loop`).
- `modernize`: Rebase and update older pull requests cleanly.
- `client-tests`: Write acceptance criteria and tests before implementing client deliverables.

**Code review, validation, and audits**
- `gemini-loop`: Iterative code review loop using Gemini 4 Neon (high) via Antigravity.
- `sol-loop`: Iterative code review loop using GPT Sol.
- `council`: Multi-model code review orchestration in T3 Code.
- `leaving-pr-comments`: Consistent attribution and style for GitHub PR comments.
- `security-audit`: Security audit checklist for apps and automation workflows.
- `ship-readiness`: Production and delivery readiness audit for client projects.
- `verify-assignment`: Final self-review of school coding assignments against the brief.

**Learning and clarity**
- `learn`: Personalized tutoring and step-by-step code walkthroughs (line by line and call-chain).
- `sum`: Condense long explanations or review reports on demand (`/sum`).

## Global rules

- `rules/GEMINI.md`: Global Antigravity rules (no em-dashes, software engineering teaching moves).

## Syncing on another Windows PC

1. Clone this repository:

```powershell
git clone https://github.com/kr1s2025/coding-skill.git
cd coding-skill
```

2. Run the sync script:

```powershell
# Copy skills into Claude, Codex, and Antigravity:
.\sync.ps1

# Or link with Windows directory junctions so edits stay in sync automatically:
.\sync.ps1 -Link
```

3. When you update skills on one PC, commit and push; on the other PC, run `git pull` (and `.\sync.ps1` if you used copy mode).
