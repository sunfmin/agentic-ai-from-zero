# Chapter 2 — Set Up Your Toolbox

_Last calibrated: 2026-05, against Claude Code v2.x_

By the end of this chapter, you'll have Claude Code installed on your Mac, logged in, and ready to use. That involves four pieces, in order: **Homebrew**, **Node.js**, **Claude Code**, and an **Anthropic login**. Each one is one command (or close to it). The chapter ends with a small sidebar comparing the three payment options.

If chapter 1 felt comfortable, this chapter will too — you're using the same five commands to navigate, plus a few new tools that you install along the way.

## A word before you start

Three of the four commands below paste a URL into Terminal. Read what you're pasting *once* before pressing Enter. You'll never have to do this on a Mac for normal use (apps come from the App Store), but installing developer tools is one place where "paste a command from a website" is genuinely standard. The websites in this chapter are first-party (brew.sh, anthropic.com); they're safe.

## 1. Install Homebrew

Homebrew is a **package manager** — software that installs other software for you. On macOS, it's the standard tool for installing developer-focused programs. You install Homebrew once; from then on, every other tool in this chapter is one Homebrew command away.

The install command lives at brew.sh. Open Terminal.app and paste this:

> 🛠 Try it
>
> Type (or paste): `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
>
> Press Enter. You'll be asked for your Mac password — type it (the cursor won't show what you type; that's normal) and press Enter.
>
> You should see: a long stream of "Downloading...", "Installing...", and finally a message like `Installation successful!` Toward the end, it may print "Next steps" with two lines about adding Homebrew to your PATH — copy and run those two lines if you see them.

Verify Homebrew is installed:

> 🛠 Try it
>
> Type: `brew --version`
>
> You should see: `Homebrew 4.x.x` (any 4-series number is fine).

If you don't see that, close and reopen Terminal.app, then try again — the install script sometimes only takes effect in a fresh terminal.

## 2. Install Node.js

Claude Code is distributed via **npm** (Node Package Manager), which ships with **Node.js**. So you need Node.js installed before you can install Claude Code. Homebrew handles it in one line.

> 🛠 Try it
>
> Type: `brew install node`
>
> You should see: Homebrew downloading and installing Node.js, finishing with a `==>` line that says it's done. The whole thing takes a minute or two depending on your network.

Verify:

> 🛠 Try it
>
> Type: `node --version`
>
> You should see: a line like `v22.x.x` (anything 18 or higher will work for Claude Code).
>
> Then type: `npm --version`
>
> You should see: a line like `10.x.x`.

## 3. Install Claude Code

One more install command:

> 🛠 Try it
>
> Type: `npm install -g @anthropic-ai/claude-code`
>
> You should see: npm downloading a series of packages, then a final line like `added NN packages in Ns`.

The `-g` flag means "install globally" — `claude` becomes a command you can type from any folder, not just one project.

Verify:

> 🛠 Try it
>
> Type: `claude --version`
>
> You should see: a line like `2.x.x (Claude Code)`.

## 4. Log in to Anthropic

Claude Code talks to Anthropic's servers to do anything useful. It needs to know which Anthropic account is yours, so it can bill the work to the right place.

This step is **not** a 🛠 box because it opens a browser window — the verification is "the browser shows a 'logged in' confirmation," not "the terminal prints a specific line."

Type `claude` (just that, no arguments) in any folder and press Enter. The first time you run it, it will:

1. Print a short setup message
2. Open your default browser to an Anthropic login page
3. Ask you to sign in (or sign up) — use the email you want billed
4. After login, redirect to a "you can close this tab" page
5. In the terminal, print a confirmation that you're logged in

If you don't yet have an Anthropic account, the login page lets you create one. **Pick the Claude Pro plan** when prompted — that's the main path this book assumes (see the sidebar below if you're curious about the alternatives).

Once you see the confirmation in the terminal, press `Ctrl+C` to exit out of `claude` for now. Chapter 3 is where the first real conversation happens.

## Sidebar — Payment options

This book recommends **Claude Pro**. The other two options exist for specific situations; you do not need them to follow the book.

| Plan | Monthly cost (approx, 2026-05) | Best for | Setup complexity |
|---|---|---|---|
| **Claude Pro** *(book default)* | US$20 | Most readers, including everyone following this book | One browser login |
| **Claude Max** | US$100–200 (tier-dependent) | Heavy daily users; people running long agentic tasks every day | Same as Pro, just a higher tier |
| **API pay-as-you-go** | Per-token billing | Developers who already have an API workflow or want to script around Claude Code | An API key in console.anthropic.com + `ANTHROPIC_API_KEY` env var |

Everything in this book — every chapter, every 🛠 box, every skill — works on Claude Pro. Switching later is straightforward.

## Recap

- `brew install …` to install developer tools
- `npm install -g @anthropic-ai/claude-code` to install Claude Code
- `claude` to launch it (first time prompts you to log in)

## Next

[Chapter 3 — *Your First Session*](./03-first-session.md). You'll create an empty folder, `cd` into it, run `claude`, and have the first real conversation — Claude reading a file you create, Claude writing a new file, Claude running a command.
