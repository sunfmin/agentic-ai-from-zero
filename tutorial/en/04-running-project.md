# Chapter 4 — Teaching Claude Your Project

_Last calibrated: 2026-05, against Claude Code v2.x_

So far you've worked in throwaway folders. Time to settle into a project you'll keep for the rest of the book — and time to teach Claude about it.

The project is small on purpose: a folder of writing drafts that need editing. You'll keep adding to it through chapters 6, 7, and 8. Each new skill will operate on these drafts.

## Set up the running project

We ship a starter folder with three drafts already in it — bad drafts, deliberately so, so the writing-review skill you build in chapter 6 has something real to critique.

> 🛠 Try it
>
> Type: `cd ~ && mkdir -p writing && cd writing`
>
> Then copy the starter drafts into it. Open the tutorial repo in Finder (download the zip from GitHub if you haven't cloned it) and look in `tutorial/en/starter/writing/`. Drag the three `.md` files into your `~/writing` folder.
>
> Alternatively, if you cloned the repo: `cp /path/to/agentic-ai-from-zero/tutorial/en/starter/writing/*.md .`
>
> Then verify: `ls`
>
> You should see: `announcement.md`, `launch-post.md`, `standup-summary.md`.

Open one of them in your favourite editor (or run `open announcement.md` to let macOS pick one). Read a paragraph. Notice how it reads — wordy, passive, abstract. Your future skill will help with exactly that.

## Launch Claude in the project

> 🛠 Try it
>
> Make sure you're in `~/writing`: `pwd`
>
> You should see: `/Users/yourname/writing`.
>
> Then: `claude`
>
> You should see: Claude's greeting, then the prompt.

`~/writing` is now Claude's working directory. Everything you do in this session is relative to it.

## Write a CLAUDE.md collaboratively

`CLAUDE.md` is a special file Claude Code reads at the start of every session in this folder. Its job is to teach Claude what *this* project is — context that's true every time you come back, so you don't have to re-explain it.

Don't write it from a template. Write it conversationally. Claude does most of the typing.

> 🛠 Try it
>
> At the Claude prompt:
>
> > Read the three drafts in this folder. Then propose a `CLAUDE.md` that explains, in 5–10 lines, what this project is — a folder of writing drafts I'm editing. Mention the kinds of issues you noticed in the drafts (wordiness, passive voice, abstract nouns), and suggest that any future skill that critiques drafts should focus on those.
>
> You should see: Claude reads the drafts, summarises what it found, proposes a `CLAUDE.md`, and asks to write it.
>
> Approve the write. Then `cat CLAUDE.md` (in another terminal, or in the same one after `/exit`) to see what got committed to disk.

The `CLAUDE.md` you just got is *yours*. Edit it freely. Add or remove. If you ever wonder why Claude is making a particular suggestion, look at `CLAUDE.md` first — it's the highest-priority context.

## Why a CLAUDE.md matters more than another prompt

You could open every session by typing "this is a folder of writing drafts; focus on wordiness…" — but you'd type it every time, and you'd type it slightly differently each time. `CLAUDE.md` ends the re-explanation. It says it once, in your words, and Claude reads it on every fresh `claude` launch in this folder.

A `CLAUDE.md` is the lightest possible form of customisation. The next step up — chapter 5 onwards — is a **skill**.

## Recap

- `CLAUDE.md` lives in a project folder; Claude reads it on every session start in that folder.
- It's project-specific, written by you (or collaboratively with Claude), and persists across sessions.
- It's a contract: "here's what's true about this project, every time."

## Next

Chapter 5 — *What's a Skill*. `CLAUDE.md` is one piece of customisation; a **skill** is the other. You'll learn what makes them different and why you'd want both.
