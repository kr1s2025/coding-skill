---
name: sum
description: Rewrite the answer Claude just gave in this conversation as a much shorter, easier-to-read version - one line with the answer, then a few bullets or steps, with commands, numbers and open questions kept exact. Use whenever the user runs /sum, says the last answer is too long or too much text, or asks to summarize, sum up or shorten it (also misspelled, like "sumeryze" or "sumarize"), or says "tl;dr", "short version", "korter", "vat samen", "te veel tekst". Only for an answer already given in this conversation. Not for summarizing a file, PDF, article or video the user shares.
argument-hint: "[optional: what to focus on, or which answer]"
---

# Sum: the last answer, but shorter

The user runs `/sum` when an answer was too much text. They want the same answer in a form they can take in within a few seconds: less text, easy to scan, nothing important lost.

## What to summarize

- **Default:** your last real answer before `/sum`. That is the text the user saw, not tool output or your working steps.
- **Text after `/sum`** either narrows the focus ("only the steps", "the part about the split") or points at something else ("the answer before that", "everything about the pipeline"). Follow it.
- **`/sum` on a summary:** if the last answer was already made by this skill, it is still too long for them. Cut it to about half.
- **Not sure which answer they mean, or there is no earlier answer:** ask one short question. Don't guess. This user prefers a question over a wrong guess.

## Only restate

Don't use tools, don't re-read files, and don't add new facts, new advice or a changed conclusion. The user trusts the summary to be the same answer. If it says something different, they can't tell which of the two is right.

If you notice the original answer was wrong, keep the summary faithful and add one line that starts with `Correction:`.

## How long

Scale with the original, and stay under about a quarter of its length:

- **A few lines:** one sentence is enough.
- **A short answer (up to about 10 lines):** one sentence, then at most 3 bullets.
- **About a screen:** one sentence, then 4 to 6 bullets.
- **Long, with several sections:** one sentence, then the steps or points (at most about 8), then 2 or 3 takeaways.

## Shape

1. First line: `**In short:**` and the answer itself in one sentence. Give the conclusion ("The test fails because the token expires too early"), not a description of the answer ("I explained why the test fails").
2. Then the points. Number them when the order matters (steps); use bullets otherwise. One idea per line, about 15 words at most. Start a line with the key word in bold when that makes it easier to scan.
3. Last, only when there is something: `**You still need to:**` with what the user has to do or decide.

**Keep exact:** commands (in a code block), file paths, names, numbers, dates and error messages. The user acts on these, so copy them unchanged instead of rewording them.

**Keep:** anything that failed or wasn't done, warnings that could cost them something, and questions that are waiting for their answer.

**Drop:** how you got there, background, caveats that don't change what they do, anything said twice, and examples (keep one if a point is unclear without it).

If you dropped a whole part they might look for later, end with one line: `Left out: ...` with just the topics.

## Easy to read

- Short sentences and everyday words.
- Technical terms and course terms stay as they are. If a term is hard and the original didn't explain it, add a few words in brackets.
- No nested bullets and no headers; bold labels are enough.
- A table only when the original compared things side by side and it fits in 3 columns.
- A blank line between the parts.
- No opening line ("Here is the summary") and no closing line ("Let me know if...").

## Language

Use the language of the answer you are summarizing. In Dutch the labels are `**Kort:**` and `**Dit moet je nog doen:**`. Code, commands and file names never change.

## Example

A long answer about a failing login test becomes:

```
**In short:** the login test fails because the token expires after 60 seconds instead of 60 minutes.

- **Cause:** `TOKEN_TTL` in `config/auth.py` is in seconds, but the code reads it as minutes
- **Fix:** I changed it to `3600`; all 42 tests pass now
- **Not done:** the refresh endpoint has the same bug

**You still need to:** decide if I should fix the refresh endpoint too.
```
