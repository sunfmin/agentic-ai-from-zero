# Chapter 5 — What's a Skill

_Last calibrated: 2026-05, against Claude Code v2.x_

Three short ideas in this chapter. Together they answer "what is a skill?" without asking you to write one yet. Chapter 6 is for writing.

## 1. A skill is not a prompt

When you typed in chapter 3 "Read `notes.md` and tell me what's in it" — that's a prompt. You typed it. Claude acted on it. Next session, the prompt is gone.

A **skill** is a *file* on disk that Claude reads automatically, every time the situation it's designed for shows up. You don't type it. You write it once and forget it; Claude remembers to apply it for you.

The mental shift is from "I'm going to say this again" to "I've written down a thing that happens whenever it's relevant." Skills are not faster prompts. They are prompts that *trigger themselves*.

A useful contrast against the previous chapter:

| `CLAUDE.md` | A skill |
|---|---|
| Lives in **one project** | Lives in **your global skills directory** (or one project, but global is the common case) |
| Read on **every session start** in that project | Read **only when its description matches the current context** |
| Project-specific context | A reusable pattern that triggers across projects |

`CLAUDE.md` is "here's what's true about this project, always." A skill is "here's what to do when a particular situation comes up, anywhere."

## 2. A skill's minimal shape

A skill lives in a folder named after the skill. The folder contains at minimum one file: `SKILL.md`. Here's an annotated minimum-viable skill (don't type this — just read it):

```markdown
---
name: review-writing
description: |
  Reviews drafts in the user's personal-writing project for wordiness,
  passive voice, and abstract phrasing. Trigger when the user asks to
  "review", "edit", or "critique" a draft, or shares a markdown file
  containing prose they want feedback on.
---

# Review Writing

When the user asks for a writing review, do the following:

1. Read the file they pointed at.
2. Check it for: wordiness, passive voice, abstract nouns instead of concrete verbs.
3. For each issue, quote the original sentence and propose a tighter rewrite.
4. End with a one-line overall assessment.
```

Two things are doing all the work.

**The frontmatter block at the top** (the lines between the `---` markers) declares the skill's `name` and `description`. The `description` is the most important field in the entire file — it's what Claude reads to decide whether this skill is relevant *to whatever you just said*. Get the description wrong and the skill never triggers; get it right and the skill triggers exactly when you wanted it.

**The body** (everything after the second `---`) is what Claude reads *once the skill is triggered*. It's the instructions, the steps, the rules. Plain Markdown.

That's the minimum. Real skills can have many more files alongside `SKILL.md` (you'll see that in chapter 7), but a single `SKILL.md` is enough to be a real skill.

## 3. How triggering works

Every time you send a prompt to Claude Code, two things happen in parallel before Claude responds:

1. Claude reads `CLAUDE.md` in the current project (if there is one).
2. Claude scans the `description` field of every available skill and asks itself: "is any of these relevant to what the user just said?"

If one or more skills match, Claude reads their full bodies and incorporates the instructions into its response. If nothing matches, Claude proceeds as if no skill existed.

The whole thing is automatic. You don't type a magic word. You don't refer to the skill by name. You just say what you want — and if a skill's description covers that case, it fires.

This is why writing the `description` carefully matters more than writing the body carefully. The body is for Claude *after* the skill triggers. The description decides *whether* it triggers at all. Chapter 8 is about tuning descriptions.

> 🛠 Try it (reflective — no skill to write yet)
>
> Look in `~/.claude/skills/` (use `ls ~/.claude/skills/` or `open ~/.claude/skills/`).
>
> You should see: a list of folders, each one is a skill that's already on your machine — maybe from the Matt Pocock skills set, maybe from Anthropic's bundled set, maybe nothing yet if your `~/.claude` is empty.

Open one and read its `SKILL.md`. Look at the frontmatter. Predict, from the description alone, when the skill would trigger. Then look at the body and check whether your prediction matches the actions described.

## Recap

- A skill is a file that triggers automatically; a prompt is text you type once.
- A skill needs at minimum a `SKILL.md` with a frontmatter (`name`, `description`) and a body.
- The `description` is the trigger — it decides whether Claude reads the body at all.

## Next

[Chapter 6 — *Your First Skill*](./06-first-skill.md). You'll write the `SKILL.md` shown above (almost verbatim), install it, and watch it trigger on the drafts in your running project.
