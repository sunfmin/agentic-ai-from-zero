# Chapter 3 — Your First Session

_Last calibrated: 2026-05, against Claude Code v2.x_

You're logged in. The next move is the simplest, and the most consequential: you ask Claude to do three things on your machine. Each one happens, and afterward we'll name what just happened.

That's the shape of this chapter. The 🛠 boxes lead; the concepts come after. Do the box, see the thing happen, then read the paragraph that names it. It works better than the reverse.

## Setup — a fresh sandbox folder

Don't run `claude` in a real project yet. Make an empty folder for this chapter and play there.

> 🛠 Try it
>
> Type: `cd ~ && mkdir -p first-session && cd first-session`
>
> Then: `pwd`
>
> You should see: `/Users/yourname/first-session`.

Now launch Claude Code:

> 🛠 Try it
>
> Type: `claude`
>
> You should see: a multi-line greeting from Claude Code, then a prompt waiting for your input. The cursor is sitting on a line that begins with `>`.

You're in. Anything you type now goes to Claude.

## Interaction 1 — make Claude read a file

First, give Claude something to read. We'll keep using the terminal you already have — but Claude can do this for us too. Watch.

> 🛠 Try it
>
> At the Claude prompt, type:
>
> > Create a file called `notes.md` here with three lines of any quick notes about your morning.
>
> You should see: Claude announces it's writing a file. It may ask you to confirm the write — say yes. Then it confirms `notes.md` was created. In Terminal, if you open a second window and `ls` in `first-session`, you'll see `notes.md`.

Now ask Claude to read it back:

> 🛠 Try it
>
> At the Claude prompt, type:
>
> > Read `notes.md` and tell me what's in it.
>
> You should see: Claude reads the file you just created and quotes the three lines back to you.

What just happened: Claude read and wrote files **in your current folder**, the one you launched `claude` from. That folder has a name: it's the **working directory**. Everything Claude does — read, write, run — happens relative to it. If you launch `claude` from `~/Desktop`, it can read your Desktop files. If you launch it from `~/first-session`, it can read only what's there.

This is a feature, not a limitation. Claude doesn't accidentally wander into your filesystem and read things you didn't intend.

## Interaction 2 — make Claude write a new file

You already wrote one file in interaction 1, but that was Claude inventing the content. Now ask for something specific.

> 🛠 Try it
>
> At the Claude prompt, type:
>
> > Create a file called `todo.md` with a checklist of three things I might want to do today. Make them realistic and short.
>
> You should see: Claude proposes the contents, asks to write the file (or writes it after confirming), and reports success. `ls` from a Finder-adjacent terminal will show `todo.md` alongside `notes.md`.

You can also re-open the file and edit it conversationally:

> 🛠 Try it
>
> At the Claude prompt, type:
>
> > Open `todo.md` and add a fourth item: "read chapter 4 of the agentic-ai tutorial".
>
> You should see: Claude reads, edits, writes the file. Open `todo.md` in any editor (or `cat todo.md` in another terminal) — the new item is there.

What just happened: when Claude needs to act on your filesystem, it asks first (sometimes once per action, sometimes once per type of action — that's a config you can tune later). Those approval prompts are called **permissions**. You can approve a single action, approve a whole category for this session, or deny. The default leans cautious; that's good for now.

## Interaction 3 — make Claude run a command

The terminal is full of commands. Claude can run them too — through the same permission system.

> 🛠 Try it
>
> At the Claude prompt, type:
>
> > Run `ls -la` here and summarise what you see.
>
> You should see: Claude announces it wants to run `ls -la`, asks permission, runs it, and reads back what's there — `notes.md`, `todo.md`, plus the hidden `.` and `..` entries.

What just happened: this whole exchange — your prompt, Claude's actions, the permission prompts in between — is one **session**. A session begins when you ran `claude` and ends when you press `Ctrl+C` or type `/exit`. Everything Claude remembers within a session is in that session; when you exit, it forgets (mostly — chapter 4 is about the one piece that *persists* across sessions: `CLAUDE.md`).

## Exit the session

> 🛠 Try it
>
> At the Claude prompt, type: `/exit`
>
> Or, press `Ctrl+C` twice.
>
> You should see: Claude prints a goodbye, you're back at the regular shell prompt (`%` or `$`). The files you created remain on disk.

## Recap — three concepts, named

- **Session** — one conversation, from `claude` launch to `/exit`. Memory lasts only as long as the session does.
- **Working directory** — the folder you launched `claude` from. Claude can only read, write, and run things relative to it.
- **Permission prompts** — Claude asks before taking actions that touch your filesystem or run shell commands. You approve one-by-one, by category, or deny.

You used all three in this chapter without being told what they were called. That's the right order: feel it, then name it.

## Next

[Chapter 4 — *Teaching Claude Your Project*](./04-running-project.md). You'll bring a small project (a writing folder) into Claude Code and write a `CLAUDE.md` for it — the one file that *does* persist across sessions.
