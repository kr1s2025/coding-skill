# coding-skill

Private repository of personal coding, code review, PR workflow, and learning skills synced across PCs for **Claude**, **Codex**, and **Antigravity**.

## Included skills (82)

### Personal skills (15)

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

### pstack skills (67)

Imported from [`michael-denyer/pstack-claude`](https://github.com/michael-denyer/pstack-claude) (v0.9.145, commit `ed29cc8`), the multi-harness port of Lauren Tan's (`@poteto`) [`pstack`](https://github.com/cursor/plugins/tree/main/pstack) with platform mappings for **Claude Code**, **Codex**, and **Antigravity (Gemini)**.

**Entry points and setup**
- `poteto-mode`, `poteto-help`, `setup-pstack`, `automate-me`, `figure-it-out`

**Design, debugging, and implementation**
- `architect`, `arena`, `benchmark-checklist`, `blast-radius`, `how`, `why`, `statechart`, `swarm`, `tdd`, `typescript-best-practices`

**Review, verification, and PR workflows**
- `babysit`, `create-verification-skill`, `maintain-verification-skill`, `create-formal-verification-skill`, `maintain-formal-verification-skill`, `deslop`, `fix-ci`, `fix-merge-conflicts`, `get-pr-comments`, `interrogate`, `make-pr-easy-to-review`, `no-comments`, `thermo-nuclear-review`, `thermo-nuclear-code-quality-review`, `thermos`, `unslop`

**Reflection, learning, and communication**
- `bro`, `correct`, `in-your-own-words`, `ketchup`, `ketchup-video`, `recall`, `reflect`, `sharpen`, `show-me-your-work`, `teach`, `technical-writing`, `what-did-i-get-done`

**Engineering principles (24, `principle-*`)**
- `principle-attack-the-premise`, `principle-boundary-discipline`, `principle-build-the-lever`, `principle-encode-lessons-in-structure`, `principle-exhaust-the-design-space`, `principle-experience-first`, `principle-explain-the-number`, `principle-fix-root-causes`, `principle-foundational-thinking`, `principle-guard-the-context-window`, `principle-laziness-protocol`, `principle-make-operations-idempotent`, `principle-migrate-callers-then-delete-legacy-apis`, `principle-minimize-reader-load`, `principle-model-the-domain`, `principle-never-block-on-the-human`, `principle-outcome-oriented-execution`, `principle-prove-it-works`, `principle-redesign-from-first-principles`, `principle-separate-before-serializing-shared-state`, `principle-sequence-verifiable-units`, `principle-subtract-before-you-add`, `principle-test-behavior-not-implementation`, `principle-type-system-discipline`

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
