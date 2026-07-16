# Chapter 17 — Where to Go Next

_Last calibrated: 2026-05, against Claude Code v2.x_

You've finished the book. You can navigate a terminal, run Claude Code, write a `SKILL.md` by hand, decompose it across files with progressive disclosure, and use `/skill-creator` to design new skills conversationally; and in Part 2 you ran a professional skill set through the "lay down a protocol → grill into decisions → synthesize a PRD → slice into issues" planning pipeline, and deepened the architecture of an existing codebase once; and in Part 3 you ran that backlog — orchestrating agents across parallel worktrees with orca, then letting an unattended afk-fleet implement and merge it. That's everything this book set out to teach.

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
