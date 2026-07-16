# Chapter 16 — Where to Go Next

_Last calibrated: 2026-07, against Claude Code v2.x_

You've finished the book. You can navigate a terminal, run Claude Code, write a `SKILL.md` by hand, decompose it across files with progressive disclosure, and use `/skill-creator` to design new skills conversationally; and in Part 2 you ran a professional skill set through the "lay down a protocol → grill into decisions → synthesize a PRD → slice into issues" planning pipeline, and deepened the architecture of an existing codebase once. That's everything this book set out to teach.

This chapter is the **off-ramp**. It does not teach the topics below — every one of them is its own book. The point here is just to tell you what's behind each door, so you can decide which one to open next.

## Anthropic's official documentation

**Claude Code docs** — `https://docs.anthropic.com/claude-code` (start here for the canonical landing page; the docs reorganize occasionally, so navigate from this root).

- What's behind it: the source of truth for the CLI's commands, configuration, environment variables, and feature flags.
- Who it's for: you, every time something the book taught you behaves differently than expected, or whenever you want to know whether a feature exists.

## The rest of the engineering-skills suite (untaught here)

**`mattpocock/skills`** — https://github.com/mattpocock/skills

Part 2 (chapters 11–15) taught only five skills from this suite: `/setup-matt-pocock-skills`, `/grill-with-docs`, `/to-spec`, `/to-tickets`, `/improve-codebase-architecture`. There are several more doors it didn't open:

- **`/tdd`** — red-green-refactor test-driven development: write a failing test first, then make the code pass it, giving the agent a steady feedback loop.
- **`/diagnosing-bugs`** — a disciplined debugging loop: reproduce → minimize → hypothesize → instrument → fix → add a regression test.
- **`/triage`** — move issues along a state machine (the five triage roles from chapter 11 exist for this).
- **`/handoff`** — compact the current conversation into a handoff document so another agent can continue the work.
- **`ask-matt`** — when you're unsure which skill fits, ask it and it routes you.

- Who it's for: you, once Part 2's planning pipeline feels natural and you want to extend into "write the code + test the code + fix the code."
- How to keep up: the repo's README links the author's newsletter, where new skills and changes are announced.

The bootstrap case study at the root of this repository ([`BOOTSTRAP-CASE-STUDY.md`](../../BOOTSTRAP-CASE-STUDY.md) / [`BOOTSTRAP-CASE-STUDY.en.md`](../../BOOTSTRAP-CASE-STUDY.en.md)) walks through one full session that ran this pipeline end-to-end — the real transcript of the Part 2 workflow.

The two doors below pick up exactly where that pipeline stops. Part 2 turns a fuzzy idea into a dependency-ordered `ready-for-agent` backlog — but *who works that backlog, and where do the agents run?* Read them top-down: **orca** is the parallel-worktree substrate the agents run in, and **afk-fleet** is the unattended fleet that works the backlog on top of it.

## orca — a fleet of CLI agents in parallel

**orca** (`stablyai/orca`) — https://github.com/stablyai/orca

- What's behind it: an orchestrator — an "agentic development environment" (ADE) — that runs a **fleet** (a standing set of parallel workers) of CLI coding agents at once, Claude Code and others, each in its own isolated git **worktree** (a second working copy of one repo, on its own branch), all tracked in one place across desktop and mobile. It is a desktop app, but *not* the "terminus" the preface contrasted with the building block: its entire job is to spawn and coordinate the CLI agents you spent this book learning to run. It is a terminus *made of* building blocks — which is only possible because the CLI is composable. Because Claude Code is a composable CLI, orca can fan many instances across worktrees, then compare and merge the winner. That makes it the sharpest single example of the building-block thesis this book runs on (see "Why the terminal," below).
- Who it's for: you, once one Claude Code session at a time isn't enough — when you want several agents running in parallel on isolated branches and kept in one view.

## afk-fleet — working a backlog unattended

**afk-fleet** (`sunfmin/afk-fleet`) — https://github.com/sunfmin/afk-fleet

- What's behind it: an unattended **fleet** (AFK = away-from-keyboard) that works a GitHub-issue backlog on its own for days. A thin launcher spawns a fresh, disposable "tick" each cycle; each tick dispatches one worktree-isolated Claude Code worker per ready issue, gates each on CI (plus, for a prose repo like this one, an optional independent adversarial-verification pass), auto-merges the green PRs, and retries-then-escalates the failures. It **consumes** exactly the backlog the `mattpocock/skills` flow above produces — `/grill-with-docs` → `/to-spec` → `/to-tickets` publishes the `ready-for-agent` issues in dependency order — and it runs its workers on **orca's** worktrees. This very repository is the worked example: its per-repo afk-fleet config and [ADR-0006](../../docs/adr/0006-orca-afk-fleet-doors.md) were produced by that loop.
- Who it's for: you, once you've decomposed a project into ready, dependency-ordered `ready-for-agent` issues and want them implemented and merged without sitting over each one.

## Hooks

**Claude Code hooks** — search "hooks" in the Anthropic docs above.

- What's behind it: a way to run your own shell commands automatically at events in a session — before / after a tool call, on session start, when Claude stops. Hooks let you enforce policy ("never write to `/etc`"), inject context ("always read this file first"), or run side effects (notifications, logging).
- Who it's for: you, once you find yourself typing the same reminder to Claude every session ("don't push to main", "always run the linter first") — that reminder belongs in a hook.

## MCP — Model Context Protocol

**MCP** — `https://modelcontextprotocol.io` and the MCP section in the Anthropic docs.

- What's behind it: an open protocol for giving Claude structured access to external tools, data sources, and APIs (Slack, Google Drive, your database, your internal services). MCP servers run alongside Claude Code and expose new tools that Claude can call.
- Who it's for: you, once you want Claude Code to read or write things that aren't on your filesystem — like opening a Jira ticket, sending a Slack message, or querying production data.

## Subagents

**Subagents** — search "subagents" or "Agent tool" in the Anthropic docs.

- What's behind it: the ability for Claude to delegate part of a task to a fresh agent with a separate context window, then summarize the result back. Useful when a task would otherwise consume too much context, or when you want parallelism.
- Who it's for: you, once your skills start handling tasks that involve large research dives, multi-step refactors, or anything where a clean context window matters more than continuity.

## Why the terminal

In the preface I promised you: Claude Code in the terminal is a building block; the desktop app is a terminus. By now you can see the weight of that line — every door above in this chapter is something only the terminal building block can assemble:

- A hook runs your own shell commands on session events — you need somewhere that can run a shell.
- An MCP server runs alongside Claude Code — you need somewhere that can start a background process.
- `claude -p` runs once and exits, wiring Claude Code into cron or CI — all of these treat Claude Code as one part inside another program.

The desktop app's chat window is handy, but it stops there: it's the destination of your conversation with the AI. The terminal isn't a destination — it's the patch panel where you wire the AI into all your other tools.

Looking a little further ahead (this is my judgment, not a fact): AI is dissolving the walls between roles, and what one person is expected to do will increasingly spill past their original lane. When that day comes, "being able to wire AI into anything" won't be an engineer's specialty — it'll be general literacy. The building block you're comfortable with today is the starting point for that literacy.

## Closing

Every chapter in this book has a calibration timestamp at the top, telling you when its commands were last verified. The timestamps will drift; Claude Code will change; the URLs above will eventually move. When something stops matching what you read here, the Anthropic docs are your first stop. Then come back and open an issue on this tutorial's repo so the next reader benefits.

Thank you for reading. Now go build something.
