# Chapter 9 — Three Exercises

_Last calibrated: 2026-05, against Claude Code v2.x_

You've reached the part of the book where you stop being a reader and start being a builder. Three exercises follow — one designer-flavored, one PM-flavored, one general. Each one has a problem statement, hints, and a **reference SKILL.md** committed alongside this chapter that you can compare against after you've taken a real swing.

The reference answers are not a grading rubric. They are one valid solution per exercise. Yours might be better.

## Exercise 1 (Designer) — Design brief reviewer

**Problem.** Design briefs land in your inbox half-finished. You want a skill that, given a brief markdown file, tells you which standard sections are missing or vague: audience, success metric, constraints, deliverables.

**Trigger surface.** Things you might say to a colleague: "can you sanity-check this brief?", "audit this brief", "what's missing from this brief?" The description should fire on all of those.

**Hints.**

- The skill body should list the four required sections explicitly. Don't make Claude infer them.
- The output format matters. A "review" that just says "looks good" is useless; one that tags each section as "present / vague / missing" with a concrete suggestion for the missing or vague ones is actionable.
- Decide what "vague" means. A skill that calls everything vague is as bad as one that calls nothing vague. Be specific.

**When you're done.** Compare to `tutorial/skills/exercises/design-brief-reviewer/SKILL.md`.

## Exercise 2 (PM) — PRD note drafter

**Problem.** You leave a meeting with a Notion page full of scrambled bullets, Slack quotes, and half-decisions. You want a skill that turns it into a structured PRD note: Problem, Proposed solution, Open questions, Decided next steps, Risks.

**Trigger surface.** "Turn this into a PRD," "draft a PRD note from this," "extract a PRD," and any close variation. Also: pasted rough content + a request to "structure this."

**Hints.**

- This is the same skill you built with `/skill-creator` in chapter 8. If you saved that one, you've already done most of the work. Use this exercise to *refine* it: which trigger phrases didn't work? What does the output look like on real-world messy input?
- The hardest part isn't the section list — it's deciding what the skill does when input is missing a section's content. Hardcode "(not in input)" or have Claude infer? The reference answer takes the explicit route.

**When you're done.** Compare to `tutorial/skills/exercises/prd-note-drafter/SKILL.md`.

## Exercise 3 (General) — Meeting action extractor

**Problem.** You take rough meeting notes — paragraphs, bullets, names dropped in passing. You want a skill that pulls action items out, each one with an owner and a due date (or flagged as missing).

**Trigger surface.** "Extract actions," "pull action items," "what did we agree to do," "list todos from this meeting." Also: pasted meeting content + "who owns what?"

**Hints.**

- The output format is the load-bearing decision. A numbered list with owner-action-date is easy to scan and easy to verify; a paragraph of prose is not.
- This skill must refuse to invent owners. If the notes say "we should test the migration" with no name attached, the action's owner is "unassigned" — not "the team," not "presumably engineering." Surface ambiguity as a flag.
- Hardest case: implicit commitments. "We're blocked on the auth bug" — is that an action? Whose? Decide and document.

**When you're done.** Compare to `tutorial/skills/exercises/meeting-action-extractor/SKILL.md`.

## How to attempt each exercise

For each one:

1. Build the skill folder under `~/.claude/skills/<skill-name>/`.
2. Write the `SKILL.md` by hand, *or* use `/skill-creator` and tune the result.
3. Test against real-feeling input — make it up if you have to, but make it messy and realistic.
4. If the skill doesn't trigger reliably, work the debugging checklist from chapter 8.
5. When the skill is doing what you want, *then* open the reference answer and read it. Note differences. Decide whether the reference is better, worse, or just different from yours.

## Recap

- Three exercises: designer, PM, general.
- Reference answers exist but are not grades — your skill might be better.
- The point of exercises 1 and 3 is to leave chapter 8 with skills *you've made*, not skills the book made for you.

## Next

[Chapter 10 — *Where to Go Next*](./10-next-steps.md). Curated outbound links for what to learn after this book. No new concepts; pure off-ramp.
