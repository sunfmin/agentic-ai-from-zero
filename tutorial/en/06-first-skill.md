# Chapter 6 — Your First Skill

_Last calibrated: 2026-05, against Claude Code v2.x_

You're going to write a `SKILL.md` by hand, install it, and watch it trigger on the drafts from your running project. By the end of this chapter the drafts you copied in chapter 4 will get reviewed — automatically — every time you mention you want them reviewed.

## Where skills live

Skills live in `~/.claude/skills/`. Each skill is a folder under that. The folder name doesn't matter for triggering — the `name` field inside `SKILL.md` does — but conventionally the folder is named after the skill.

> 🛠 Try it
>
> Type: `mkdir -p ~/.claude/skills/review-writing`
>
> Then: `ls ~/.claude/skills/`
>
> You should see: a list including `review-writing` (and any other skills you already had).

## Write the SKILL.md

Open the new folder in your editor (or run `open ~/.claude/skills/review-writing` and create a file in the Finder window). Create a file called `SKILL.md` with the contents below.

Type it (or paste it) into the file. The exact wording matters less than the *shape* — frontmatter at top, body below.

```markdown
---
name: review-writing
description: |
  Reviews drafts (markdown files containing prose, blog posts, announcements,
  meeting summaries, launch notes, internal communications) for four common
  writing problems: wordiness, passive voice, abstract nouns where concrete
  verbs would work, and filler / corporate-speak. Trigger when the user asks
  to "review", "edit", "critique", "improve", "tighten", or "give feedback on"
  a draft or any prose, or when they share a markdown file and ask what's
  wrong with it.
---

# Review Writing

When the user asks for a writing review on a draft, do the following:

1. Read the file the user points at. If they don't name a file, ask which one.
2. Check the prose against the four **principles** below. For each issue you find, quote the original sentence and propose a tighter rewrite.
3. End the review with a one-line overall assessment that names which of the four principles the draft struggles with most.

## Principles

**P1 — One idea per sentence.** Sentences that string together two or more independent claims with "and", ", which", or semicolons usually hide a structural problem. Split them. If a sentence has more than ~30 words, suspect P1 violation.

**P2 — Active voice.** "X was done by Y" almost always reads worse than "Y did X." Look for `was/were/been/being + past participle` constructions and rewrite as active.

**P3 — Concrete verbs over abstract nouns.** "We made an improvement to" → "We improved." "The deployment of the tool was completed" → "We deployed the tool." Nominalizations (verbs turned into nouns: improvement, deployment, completion, identification, optimization) signal P3 violations.

**P4 — Cut filler and corporate-speak.** Phrases that sound important but mean nothing: "going forward", "at the end of the day", "leverage", "synergy", "drive value", "in order to", "for the purpose of", "as part of our broader X journey". Delete them; the sentence usually still works.

## Output format

For each issue, use this shape:

> **[Principle code]** Original: "..."
> Rewrite: "..."

Then at the bottom:

> **Overall:** This draft struggles most with [principle code]. [One-sentence summary.]

Be specific and direct. Don't soften with "consider" or "you might want to". The user asked for a review; give one.
```

> 🛠 Try it
>
> After saving the file, run: `cat ~/.claude/skills/review-writing/SKILL.md | head -10`
>
> You should see: the first ten lines of what you wrote — the frontmatter block and the start of the body.

## Watch it trigger

Now go back to your running project — the writing folder from chapter 4.

> 🛠 Try it
>
> Type: `cd ~/writing && claude`
>
> You should see: Claude's normal greeting and prompt.

The skill is now available to Claude. You didn't have to "load" anything. Claude scans `~/.claude/skills/` automatically.

Trigger it:

> 🛠 Try it
>
> At the Claude prompt, type:
>
> > Review `announcement.md` for me.
>
> You should see: Claude reads `announcement.md`, then produces a review. Look for **P1**, **P2**, **P3**, or **P4** codes in the output — those are the principle codes from your skill body. If you see them, the skill triggered. If you see a generic review with no codes, the skill didn't trigger — go to the troubleshooting section.

Try it on the other two drafts too:

> 🛠 Try it
>
> > Critique `launch-post.md`.
>
> Then:
>
> > Give me feedback on `standup-summary.md`.
>
> You should see: each one gets the same shape of review — quoted sentences with principle codes attached, an overall assessment at the end.

Both `review` and `critique` and `give me feedback on` trigger this skill — because all three phrases are explicitly named in the `description` field's trigger language.

## Troubleshooting — the skill didn't trigger

If you got a review *without* principle codes, the skill didn't fire. The likely cause is the `description`. Check:

- Is `SKILL.md` exactly at `~/.claude/skills/review-writing/SKILL.md`? Not `Skill.md`, not `skill.md`, not `~/skills/SKILL.md`.
- Did you save the file? (Open it again from a fresh terminal: `cat ~/.claude/skills/review-writing/SKILL.md`.)
- Did you start a fresh `claude` session after creating the file? Older sessions may not see newly-added skills.
- Is the frontmatter delimited by exactly three dashes, on their own lines, top and bottom?

If the structure looks right but the skill still doesn't trigger on phrases like "review this draft," the issue is probably wording in the description. Chapter 8 is about tuning descriptions; come back to this skill then.

## Recap

- A skill on disk = a folder under `~/.claude/skills/` containing `SKILL.md`.
- No reload, no registration, no command — `claude` discovers skills automatically at session start.
- Triggering depends on the wording of the `description` matching what you ask for.

## Next

Chapter 7 — *Multi-File Skills*. You'll take the `SKILL.md` you just wrote and refactor it into multiple files using progressive disclosure. The skill will do the same thing — but its insides will look very different.
