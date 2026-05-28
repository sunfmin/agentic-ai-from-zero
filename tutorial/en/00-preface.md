# Preface — From the Chat Box

_Last calibrated: 2026-05, against Claude Code v2.x_

You've used Claude.ai or ChatGPT on the web. You know what it feels like to type a question and watch the answer appear. You may even have paid for a plan and grown comfortable with one of these tools. But you've started to hit walls:

- It can read what you paste, but it can't open your folder of drafts directly.
- It can suggest commands, but it can't run them and show you the output.
- You can prompt it the same way fifty times, but you can't *save* that pattern so the AI applies it without your asking.

This tutorial is about climbing over those walls.

## Why this tutorial exists

Claude Code is Anthropic's CLI agent — the same Claude you've been chatting with, but running in your terminal instead of a web page. It can:

- Read and write files in your project directly
- Run commands and read the output
- Be taught patterns — called **skills** — that it automatically applies when relevant

If you've never opened a terminal, that last sentence has at least three words that need explaining: **CLI**, **terminal**, **skill**. By the end of this book you'll know what each one means. You'll have written your own skill. You'll have upgraded it from one file to many using a technique called *progressive disclosure*. And you'll know how to ask Claude to design new skills for you.

## What you'll be able to do at the end

- Open the terminal on your Mac without panicking
- Install Claude Code and have your first conversation in it
- Set up a project Claude can read and modify
- Write a `SKILL.md` file by hand and watch Claude trigger it automatically
- Refactor that skill into multiple files following progressive disclosure
- Use `/skill-creator` to design new skills conversationally

## Prerequisites

This book is honest about what it doesn't cover.

- **A Mac.** This book is macOS only. Windows and Linux readers are out of scope — see [ADR-0001](../../docs/adr/0001-tutorial-scope.md) for the reasoning.
- **Stable access to `google.com` and `anthropic.com`.** If you're in a region where these aren't reachable, you need to solve that *before* you start chapter 2. The book does not cover VPN setup.
- **A Visa or Mastercard.** Claude Code charges through Anthropic. The book recommends a Claude Pro subscription as the simplest path — about US$20 per month at the time of writing.

If any of those three is missing, stop here. The book can't help you bridge those gaps, and it's more honest to tell you up front than to leave you stranded in chapter 2.

## How to read this book

Every chapter follows the same shape:

- A short header showing when the chapter was last verified ("calibrated") and against which Claude Code version
- Prose explaining the concepts
- 🛠 **Try it** boxes you do on your own machine before moving on
- A one-line lead-in to the next chapter

The **Try it** boxes are the most important part. Reading without typing won't get you from chapter 0 to writing a skill — you have to actually run things. Every box has a "you should see…" line so you can verify the result before continuing.

If a chapter's calibration timestamp is more than a few months old, treat its commands with mild suspicion — Claude Code ships new versions every week or two. Most things won't have changed, but if something doesn't match, check Anthropic's official documentation before concluding the book is broken.

## Next

Chapter 1 — *Meet the Terminal*. Five commands, twenty minutes, and the entire mystery of "the command line" cracks open.
