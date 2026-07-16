# Chapter 16 — Run Your Backlog: Orchestrate Agents with orca and afk-fleet

_Last calibrated: 2026-07, against Claude Code v2.x_

Part 2 ended with a **backlog**: a pile of `ready-for-agent` issues, cut into vertical slices and ordered by dependency (chapter 14). You built the plan. This chapter — **Part 3, the 执行篇 ("run it") movement** — is about the obvious next question: *who actually implements that backlog, and where do they run?*

Two tools answer it, and you'll **use** them, not build them (same posture Part 2 took toward the five skills):

- **orca** — the substrate: it runs several Claude Code agents **in parallel, each in its own isolated copy of the repo**.
- **afk-fleet** — the consumer: an **unattended fleet** that walks the backlog issue by issue, puts a worker on each, and merges the ones that pass — while you're away from the keyboard.

This is the payoff the preface promised. Back there I said Claude Code in the terminal is a **building block**, and the desktop app a **terminus**. orca is a desktop app — but its entire job is to spawn and coordinate **CLI** Claude Code agents. It isn't a chat window you stop at; it's the clearest example in the whole book of the building block getting **assembled into something larger**. (It doesn't make the CLI "more capable" than the desktop app — it makes the CLI *composable*, which is a different, truer claim.)

## First word: worktree

You've used git to checkpoint and share (chapter 10). One more piece of git vocabulary unlocks this chapter:

- **worktree** — a second working copy of one repo, on its own branch, in its own folder (git ≈ 独立工作副本). Normally a repo has one working copy and you switch branches inside it. A worktree lets you have *many* checkouts of the same repo side by side — so two agents can edit "the same project" at once without ever touching each other's files.

That's the trick that makes parallel agents safe: **one worktree per issue**. Agent A works issue #12 in its worktree on branch `issue-12-…`; agent B works issue #13 in another. Neither sees the other's half-finished edits. Each opens a pull request when done.

## orca: agents in parallel

**orca** (`stablyai/orca`) is an **ADE** — an *agentic development environment*, a desktop app whose job is running a fleet of coding agents at once. Each agent gets its own worktree and branch; you watch them all in one window and merge the winner.

> 🛠 Try it
>
> Download orca from `https://onorca.dev/download` and install it like any Mac app. Open it and point it at a repo folder you have handy — the practice repo from Part 2 is perfect, since it already has a backlog of issues.
>
> You should see: orca open your repo, with your coding agent (Claude Code) available and a place to spawn worktrees.

> 💡 orca isn't Claude-only — it can drive Codex, OpenCode, and others side by side. This book only cares that it runs **Claude Code**, the agent you already know.

Now fan out. Instead of one session doing issues one after another, give each open issue its own agent:

> 🛠 Try it
>
> Create a worktree for one issue and spawn a Claude Code in it (in orca, "new worktree" → pick the issue / branch name → start an agent), then do the same for a second issue. Hand each agent its issue ("implement issue #N").
>
> You should see: two agents working **at the same time**, each in its own worktree on its own branch, neither disturbing the other's files. When one finishes, it opens a PR you can review and merge.

That's the whole idea: parallelism you can watch. But you're still the one starting each agent and merging each PR. The next tool removes even that.

## afk-fleet: the backlog works itself

**afk-fleet** (`sunfmin/afk-fleet`) is a skill — the tutorial author's own, built on top of orca — that turns "start an agent per issue and merge the good ones" into a standing, unattended loop. "AFK" is *away-from-keyboard*: you point it at the repo, authorize it once, and walk away. Three moving parts:

- **launcher** — the session you run `/afk-fleet` in. It authorizes once, then loops.
- **tick** — a fresh, disposable pass the launcher spawns each cycle: it looks at GitHub, dispatches workers to ready issues, merges what's green, and exits. (Being disposable is why it can run for days without any one session filling up.)
- **worker** — one Claude Code per `ready-for-agent` issue, each in its own **orca worktree**, talking to you only through its PR.

> 🛠 Try it
>
> Install it the same way you installed the engineering suite: `npx skills@latest add sunfmin/afk-fleet`. Then, in a session in your practice repo, do a **dry run** first:
>
> > `/afk-fleet --plan`
>
> You should see: afk-fleet read your repo's ready issues and print the **dispatch plan** — which issues it *would* pick up, in what order — while merging and changing **nothing**. A dry run needs no authorization.

The dry run is the safe way to see what the fleet sees. When you let it actually work, you choose **how far each worker goes on its own** — there are two settings:

- **Hold at the PR** (the default when you don't grant auto-merge — e.g. a `/afk-fleet --tick` run cold): each worker opens its PR and runs the gate, then **stops there**. You review and merge yourself. The fleet still does all the tedious part — dispatch, worktrees, gate — but the last click stays human.
- **Auto-merge to `main`** (opt-in, behind one explicit authorization): green PRs squash-merge into `main` unattended. This is the full AFK mode, and it's the most consequential thing the whole book asks you to turn on, so read it slowly:

> ⚠️ Authorizing auto-merge means `/afk-fleet` will **push branches to your remote and merge green PRs into `main` without asking each time**. That is the point — unattended means unattended — but only ever grant it on a repo where an automatic merge to `main` is acceptable (a practice repo, or a project with a real gate before deploy). Withhold it and the fleet simply holds at open PRs for you. Either way the fleet's job **ends at `main`**; shipping past that stays a separate, human step.

What stands between a worker's PR and `main` is the **gate**. On a repo with CI, that's the checks going green. This book's own repo has no CI — it's prose — so its fleet config (`docs/agents/afk-fleet.md`) uses an **independent adversarial-verification** pass instead: a separate agent re-reads each PR against the issue's acceptance criteria and tries to *refute* it before merge, because a machine can't tell good prose from wrong prose.

> 🛠 Try it
>
> When you're ready, run `/afk-fleet` (no `--plan`) and give it the auto-merge authorization it asks for. (Prefer to eyeball each PR yourself? Withhold it — or run a `/afk-fleet --tick` cold — and the fleet dispatches, gates, and stops at open PRs.)
>
> You should see: ticks begin dispatching workers — one per ready issue — each in its own orca worktree; PRs open; the gate runs; green PRs squash-merge to `main`; failures retry a couple of times and then escalate (labeled for a human, with a comment explaining where it got stuck). Issues whose blockers aren't merged yet wait their turn. You can close the laptop; the loop keeps going.

> 💡 This is not a toy example. This very repo's backlog — including the chapter you're reading — was run exactly this way: a Part 2 pipeline produced the issues, and an afk-fleet worked them through orca worktrees. The book documents its own construction.

## Why the terminal, one more time

Look at what just happened. A desktop app (orca) started many terminal agents; a skill (afk-fleet) drove that app in a loop and wired it to GitHub. Every layer here rests on Claude Code being a **CLI building block**: something you can spawn many of, script around, and compose into a bigger machine. A chat window you stop at could never be the bottom of this stack. That's the whole reason the book walked you through the terminal door — chapter 17 says the rest.

## Recap

- Part 3 answers "who runs the backlog Part 2 produced, and where."
- **worktree**: a second working copy of a repo on its own branch — one per issue is what makes parallel agents safe.
- **orca**: a desktop ADE that runs several Claude Code agents in parallel worktrees; you watch and merge. It's the building-block thesis paying off, not a terminus.
- **afk-fleet**: the author's own skill, built on orca — a launcher spawns disposable ticks that put a worker on each `ready-for-agent` issue and gate each PR; grant auto-merge and it merges the green ones unattended, withhold it and it holds at the PR.
- Always `/afk-fleet --plan` first. Merging is a choice: **hold at the PR** (default — you review and merge) or **auto-merge to `main`** (opt-in, behind one authorization); grant auto-merge only where it's acceptable. The gate (CI, or adversarial verification for prose) is what protects `main`.
- You use both tools; you don't build them.

## Next

[Chapter 17 — *Where to Go Next*](./17-next-steps.md). That's everything this book set out to teach — Part 1 built and shared a skill, Part 2 planned real work, Part 3 ran it. The final chapter is the off-ramp: what's still untaught, and what's behind the bigger doors.
