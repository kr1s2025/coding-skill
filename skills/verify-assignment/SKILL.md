---
name: verify-assignment
description: Final self-review of a school/coursework assignment against its brief. Use this whenever wrapping up work on an assignment from a teacher/school (Android/Kotlin/Compose, but also any other course project) — for example when the user says "de opdracht is af", "check de opdracht", "klopt dit met de opdracht?", "heb ik alles gedaan?", or right after finishing a feature that was requested by an assignment PDF/slides. Reads the assignment brief and all provided resources, then produces a short report covering three things: (1) is everything in the brief done, (2) was anything done outside the requested scope, (3) is any code too advanced for a 3rd-year college (hogeschool) IT student to immediately understand. Reports only — it does not change code unless explicitly asked.
---

# Verify Assignment

Run a final review of a school/teacher assignment and produce a **short, scannable report**. The goal is to catch three failure modes that hurt a student's grade or oral defense: missing requirements, scope creep, and code that is too clever to explain.

The student studies at a Belgian hogeschool (3rd-year IT). They will often have to **defend this code orally**, so anything they can't explain is a real risk — even if it works.

## Inputs

- **The assignment brief**: a PDF, slide deck, or text from the teacher (often in `Downloads/`, a `docs/` folder, or pasted in chat). If you can't find it, ask the user where it is — don't guess the requirements.
- **The project code** being submitted.

If the brief is a PDF and normal reading fails, extract its text first (e.g. `pdfplumber` or `pdftotext`).

## The three checks

### 1. Completeness — is everything in the brief done?
Turn the brief into a concrete checklist of every requirement (functional and technical: "CRUD via REST", "dark mode setting", "navigation between 2 screens", etc.). For each item, find where it's implemented in the code and cite `file:line`. Mark anything missing or only half-done.

### 2. Scope — was anything done that wasn't asked?
List features/files/dependencies that go beyond the brief. Extra work isn't automatically wrong (a "creative" extra is often allowed and even rewarded), so **don't tell the student to delete things** — just flag them so they're aware and can decide. The real danger this catches: added complexity the student didn't intend and can't defend.

### 3. Complexity — can a 3rd-year IT student explain this?
Flag code that is more advanced than the course level. This is the most valuable check, because over-clever code is a liability in an oral exam. Watch for things like:
- patterns not covered in the course (e.g. heavy generics, custom delegates, reflection, complex coroutine/Flow operators when a simple `viewModelScope.launch` would do)
- dense one-liners, clever chained operators, or abstractions that hide what's happening
- anything where you think "a student would struggle to say *why* this line is here"

For each flag, name the file:line, say in one sentence why it's hard, and suggest a simpler equivalent at course level (don't rewrite unless asked).

## Build check

Run the project's build (for Android: `./gradlew assembleDebug`) and report pass/fail with the key error if it fails. A submission that doesn't compile fails regardless of the checklist. If you can't run the build, say so — don't claim it passes.

## Report format

Keep it short and scannable — this is a quick check, not an essay. Use this structure:

```
# Opdracht-check: <project/opdracht naam>

## ✅ Volledigheid
| Vereiste | Status | Waar |
|---|---|---|
| <vereiste> | ✅ / ⚠️ / ❌ | file:line of "ontbreekt" |

## 🔍 Buiten scope (ter info, niet per se fout)
- <extra feature> — file:line

## 🎓 Te moeilijke code voor 3de jaar
- file:line — <waarom moeilijk> → <eenvoudiger alternatief>

## 🔨 Build
<pass/fail + evt. fout>

## Samenvatting
<2-3 zinnen: klaar om in te dienen? wat eerst nog fixen?>
```

If a section has nothing to report, write "Niks gevonden" rather than dropping it — the student should see that you checked.

## Rules

- **Report, don't refactor.** Default to read-only. Only change code if the user explicitly asks; then show a short plan and make the smallest possible diff at course level.
- **Ground every claim** in the actual brief and actual code (`file:line`) and actual build output — never assume a requirement or a pass.
- **Match the level.** Suggestions must stay at 3rd-year hogeschool level; never suggest making code *more* advanced.
