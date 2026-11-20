---
name: client-tests
description: Acceptance criteria + tests BEFORE code, for anything built for a client. This skill should be used whenever the user starts building — or asks to build — software a client will receive or use - automations, lead flows, integrations, AI agents, chatbots, websites, dashboards. Trigger even when the user ONLY states a goal and never mentions tests or specs - e.g. "build an auto-reply for installer X", "bouw een automation die leads beantwoordt", "I want a system that adds leads to the CRM", "maak een booking flow voor deze klant". Also when the user explicitly asks for tests or acceptance criteria ("maak eerst de tests", "write the tests for this"). Produces criteria + a failing test suite, then STOPS for user approval — it never starts implementing. Do NOT trigger for throwaway experiments, internal spikes, or debugging existing code.
---

# Client Tests — spec and tests before code, then stop

Purpose: derive the tests from the client-facing spec **before any implementation exists**, so
that later, "all tests pass" means "the spec is met" — not "the code agrees with itself". This
skill ends at a hard stop: present the tests, wait for the user. Implementation is a separate,
user-initiated step.

## Phase 1 — Acceptance criteria (with the user)

1. Take the user's goal. Extract every implied requirement.
2. Draft acceptance criteria as **observable, testable statements** — what an outside tester could
   verify without reading the code. Include:
   - Happy path(s), with concrete thresholds where relevant ("reply sent within 60s").
   - Failure and edge cases: malformed input, duplicates, retries/idempotency, empty payloads,
     third-party API down.
   - Explicit **non-goals**.
3. Confirm the draft with the user before writing tests. Never silently invent business rules
   (pricing, client-facing email wording, GDPR-relevant data handling) — ask.
4. Write the confirmed criteria to `ACCEPTANCE.md` in the project root. Scale to project size: a
   small webhook flow needs ~5 criteria, not 30.

## Phase 2 — Tests from the spec

1. Write the test suite **derived only from `ACCEPTANCE.md`**. Tag each test with the criterion it
   covers (`# AC-3: duplicate lead is not emailed twice`). Every criterion gets at least one test.
2. Prefer tests at the boundary the client experiences (invoke the function/endpoint, assert the
   observable result) over unit tests of internals.
3. Run the suite once to confirm every test **fails for the right reason** (missing
   implementation, not broken setup).
4. Put this header comment at the top of each test file, so the rule survives into any future
   session that touches the code:

   ```
   # Derived from ACCEPTANCE.md — these tests define "done" for the client.
   # Do NOT weaken, skip, or delete a test to make it pass. If a test seems
   # wrong, stop and ask the user; change it only with their approval.
   ```

## Phase 3 — Advisor review

Consult the `advisor` agent (user-level, Fable 5). Give it `ACCEPTANCE.md` + the test file paths
and ask: "Does this test plan actually cover the acceptance criteria? What is missing, and which
criterion is weakest-covered?" Apply the feedback. If it flags a criterion as untestable, sharpen
the criterion with the user — do not drop it.

## Phase 4 — STOP and hand over to the user

Present: the criteria (short list), the test files with a one-line summary per test, and anything
the advisor flagged. Then **stop — do not implement anything**. The user reviews and tweaks the
tests, and starts implementation themselves with a separate instruction ("code it", "maak de
tests groen"). When that later instruction comes, the test-file header rule applies: implement
until green, never weaken a test without the user's approval.
