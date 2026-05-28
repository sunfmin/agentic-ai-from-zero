# Chapter 8 — Using skill-creator

_Last calibrated: 2026-05, against Claude Code v2.x_

So far you've written a skill by hand, twice (single-file, then multi-file). Now you flip the workflow: you describe what you want, and Claude writes the skill *for you* via the built-in `/skill-creator`. Then we tackle the most common follow-up problem — a skill that doesn't reliably trigger — and learn how to fix its `description`.

The example for this chapter is deliberately different from the writing-review skill. You'll build a **PRD-note drafter** — turn a messy mix of meeting notes, Slack quotes, and bullet points into a structured PRD note. (That same skill will reappear as the PM-flavored exercise in chapter 9.)

## Use /skill-creator

Open Claude in any folder — the skill we'll create is global, so it doesn't matter where.

> 🛠 Try it
>
> Type: `cd ~ && claude`
>
> At the Claude prompt, type: `/skill-creator`
>
> You should see: a multi-line response from Claude introducing the skill-creator flow. It will ask you what you want the skill to do, who triggers it, what inputs to expect, what the output should look like.

Answer in your own words. Don't try to write a `SKILL.md` in your head first — just describe the job:

> 🛠 Try it
>
> Respond with something like:
>
> > I want a skill that turns rough meeting notes (paragraphs, bullet points, Slack quotes, mixed messy content) into a structured PRD note. The output should have these sections: Problem, Proposed solution, Open questions, Decided next steps, Risks. Trigger when I say "turn this into a PRD", "draft a PRD from this", or "extract a PRD note from these notes". The user will paste the rough content into the prompt or point at a file.
>
> You should see: Claude proposes a `SKILL.md` body — frontmatter with name and description, plus a body with the section list and the trigger logic. It will ask if it should write the file.

Approve. Look at what got created:

> 🛠 Try it
>
> Type: `ls ~/.claude/skills/`
>
> You should see: your existing skills (like `review-writing`) plus a new folder with whatever name `/skill-creator` chose — likely something like `prd-note-drafter`.
>
> Then: `cat ~/.claude/skills/prd-note-drafter/SKILL.md` (or whatever name was used)
>
> You should see: a complete `SKILL.md` with the frontmatter, description, body sections, and trigger phrases — already laid out the way the chapter-6 hand-written skill is.

## Try it on real input

Test the skill works. Paste some rough text and let the skill restructure it:

> 🛠 Try it
>
> At the Claude prompt, paste a chunk of mixed text — for example:
>
> > Turn this into a PRD: "from yesterday's meeting: people are confused about the new dashboard, especially the filter sidebar. Felix said we should hide it by default. Engineering pushback — they don't want to change the default state mid-quarter. Sarah suggested we ship a tutorial overlay instead. Open: do we A/B test or just ship. Action: design mock for hidden-by-default by Friday."
>
> You should see: Claude produces a structured PRD note with the sections Problem, Proposed solution, Open questions, Decided next steps, Risks — populated with content extracted and rephrased from the rough text.

The skill triggered (you said "turn this into a PRD," which the description listed). The output followed your specified shape. Repeat the test once or twice with different rough inputs and see if it holds up.

## When triggers misfire

A common failure: a skill works for one phrasing but not another. You say "turn this into a PRD" and it fires. You say "make a PRD note out of this" and it doesn't. Both *should* work. The fix is not to change your phrasing forever — it's to change the description.

The skill-creator flow gave the skill a description. Look at it:

> 🛠 Try it
>
> Type: `head -10 ~/.claude/skills/prd-note-drafter/SKILL.md` (substitute the actual folder name)
>
> You should see: the frontmatter block, including the `description` field. Read it carefully. Notice which trigger phrases it does list — and which it doesn't.

If you want broader triggering, expand the description's trigger language. Here's a **before/after** example:

**Before** (narrow):

```yaml
description: |
  Drafts a structured PRD note from rough meeting input. Trigger when the
  user says "turn this into a PRD".
```

**After** (broader):

```yaml
description: |
  Drafts a structured PRD note from any kind of rough input — meeting
  notes, Slack quotes, bullet lists, mixed messy text. Output sections:
  Problem, Proposed solution, Open questions, Decided next steps, Risks.
  Trigger when the user asks to "turn this into a PRD", "draft a PRD",
  "make a PRD note", "extract a PRD from this", "write up these notes
  as a PRD", or any close variation. Also trigger if the user pastes
  rough meeting content and asks for a structured writeup.
```

What changed: more synonyms ("draft", "make", "extract", "write up"), more input descriptions (Slack quotes, bullet lists), one fallback rule ("rough meeting content + structured writeup"). The body didn't change at all — only the trigger surface widened.

> 🛠 Try it
>
> Open `~/.claude/skills/prd-note-drafter/SKILL.md` in your editor and replace its `description` with the broader version above.
>
> Then in a fresh `claude` session, try a phrasing the *original* didn't catch: e.g. "make a PRD note from this stuff: [paste content]".
>
> You should see: the skill triggers and produces the PRD-shaped output.

## Debugging checklist — "my skill isn't firing"

Keep this list around. When a skill misbehaves, go through it in order:

1. **File location.** Is `SKILL.md` at `~/.claude/skills/<skill-name>/SKILL.md`? Right capitalization?
2. **Frontmatter delimiters.** Exactly three dashes (`---`) on their own line, top and bottom of the YAML block?
3. **Required fields.** Does the frontmatter have both `name` and `description`?
4. **Fresh session.** Did you start a new `claude` after creating or editing the skill? Old sessions don't see updates.
5. **Description coverage.** Read your description out loud. Did you actually say *the phrases the user would type*? "Trigger when X" only works if X matches what the user actually says.
6. **Trigger specificity.** A description that fires too often (overlapping with other skills) is as bad as one that doesn't fire enough. If multiple skills could plausibly trigger, narrow each one's description until they don't overlap.

If a skill still doesn't trigger after running through this list, simplify the description radically (one sentence, one clear trigger phrase, no qualifications), confirm it triggers on that one phrase, then re-widen step by step.

## Recap

- `/skill-creator` turns a description-in-prose into a complete `SKILL.md` for you.
- The skill it produces is *yours* — review and edit it like any other file.
- When a skill misfires, the fix is almost always in the `description` — the body is fine.
- Keep the debugging checklist handy; it covers 90% of misfires.

## Next

Chapter 9 — *Three Exercises*. You'll get three stretch tasks, one each for a designer scenario, a PM scenario, and a general scenario — with reference `SKILL.md` answers under `tutorial/skills/exercises/` for when you want to compare.
