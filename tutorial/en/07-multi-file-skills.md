# Chapter 7 — Multi-File Skills (Progressive Disclosure)

_Last calibrated: 2026-05, against Claude Code v2.x_

The skill you wrote in chapter 6 works. The body is a few hundred words. That's fine — for now.

But imagine the skill grows. You add three more principles, plus examples for each, plus an output-format spec, plus a list of phrases you specifically want to ban. Suddenly `SKILL.md` is two thousand words long. Every time the skill triggers, Claude reads all two thousand. For a quick review, that's expensive — and worse, the relevant instructions get buried in the bulk.

**Progressive disclosure** is the pattern that solves this. Split the skill across multiple files. Keep `SKILL.md` small and pointer-heavy; put the bulky reference material in sibling files. `SKILL.md` says "when this kind of review is requested, *also read principles.md*" — and Claude does, but only at the moment the principle list is actually needed.

In this chapter you'll take the chapter-6 skill and refactor it into a multi-file version. **No new content** — same four principles, same output format, same trigger phrases. Only the file shape changes. That's the whole point: feel the shape difference, not a content difference.

## Look at v2 alongside v1

We ship both versions in this repo, under `tutorial/skills/`:

> 🛠 Try it
>
> Type: `ls tutorial/skills/review-writing-v1/`
>
> You should see: `SKILL.md`, `fixture-draft.md`.
>
> Then: `ls tutorial/skills/review-writing-v2/`
>
> You should see: `SKILL.md`, `principles.md`, `fixture-draft.md`.

The same skill — twice. The v1 `SKILL.md` is 42 lines. The v2 `SKILL.md` is around 25, with a one-line link to `principles.md` for the bulky reference content.

Compare the two `SKILL.md` files:

> 🛠 Try it
>
> Type: `diff tutorial/skills/review-writing-v1/SKILL.md tutorial/skills/review-writing-v2/SKILL.md`
>
> You should see: the v2 `SKILL.md` body refers to `principles.md` instead of inlining the principle definitions. The frontmatter (`name`, `description`) is identical — trigger behavior must not change between v1 and v2.

## The shape of progressive disclosure

The v2 `SKILL.md` body now looks like this:

```markdown
# Review Writing

When the user asks for a writing review on a draft:

1. Read the file the user points at. If they don't name a file, ask which one.
2. Read [principles.md](./principles.md) for the four principles (P1..P4) and how to spot each one.
3. Check the draft against the principles. For each issue, ...
4. End the review with a one-line overall assessment ...
```

Step 2 is the new shape. It tells Claude: "the actual rules are in a sibling file; read that file when you need them." Claude follows the link only after the skill triggers — never speculatively, never just because the skill exists.

`principles.md` itself is plain Markdown with the four principles, each with one or two example before/after pairs. No special syntax. Just content you've moved out of `SKILL.md`.

## Why this is worth the extra file

Three reasons, in order of importance.

**1. The description's job stays clean.** Claude scans the `description` field of *every* skill on disk every time you type a prompt. The body is read only after trigger. Keeping `SKILL.md` small means the description sits in a thinner file — faster to load, less noise around the trigger language. (For small skills this barely matters; for a folder with 50 skills it adds up.)

**2. The skill stays comprehensible.** A 200-line `SKILL.md` is hard to scan. A 25-line `SKILL.md` that links to focused sibling files lets you orient quickly: "what does this skill do? what other files does it pull in?" The structure tells you.

**3. Pieces become independently revisable.** When you want to add a new principle, you edit `principles.md` — not `SKILL.md`. The trigger logic and the principle list change for different reasons, at different times, often by different people. Splitting them lets each evolve without disturbing the other.

## Install v2 and confirm the behavior matches

Replace the `~/.claude/skills/review-writing/SKILL.md` you wrote in chapter 6 with the v2 version, and copy the new `principles.md` next to it.

> 🛠 Try it
>
> Type: `cp tutorial/skills/review-writing-v2/SKILL.md ~/.claude/skills/review-writing/SKILL.md`
>
> Then: `cp tutorial/skills/review-writing-v2/principles.md ~/.claude/skills/review-writing/principles.md`
>
> Then: `ls ~/.claude/skills/review-writing/`
>
> You should see: `SKILL.md` and `principles.md`.

Trigger the skill the same way you did in chapter 6:

> 🛠 Try it
>
> Type: `cd ~/writing && claude`
>
> At the Claude prompt:
>
> > Review `announcement.md` for me.
>
> You should see: a review with the same four principle codes (P1..P4), the same overall-assessment line at the bottom. If the *output* matches what v1 produced, the refactor is correct. If you see anything different — missing codes, different code names, no overall line — something's off; revert to v1 (`cp tutorial/skills/review-writing-v1/SKILL.md ~/.claude/skills/review-writing/SKILL.md && rm ~/.claude/skills/review-writing/principles.md`) and compare.

## When *not* to use progressive disclosure

A single-file SKILL.md is the right answer when:

- The whole skill fits comfortably in ~50 lines, with no long reference content
- The skill has one focused job, no branches based on context
- You're still iterating on what the skill should do — splitting prematurely freezes the wrong structure

Don't refactor until you've felt the friction of *not* refactoring. v1 is fine. v2 is what you grow into.

## Recap

- Progressive disclosure = `SKILL.md` is small and points at sibling files; siblings are read only when the skill triggers.
- v1 → v2 is a refactor: same trigger, same output, only the file shape changes.
- The win is in clarity and revisability, not in performance per se.

## Next

[Chapter 8 — *Using skill-creator*](./08-skill-creator.md). Instead of writing a `SKILL.md` by hand, you'll describe a new skill in plain prose and watch `/skill-creator` produce the file shape for you. You'll also learn how to fix descriptions that don't trigger reliably.
