# Teach the CLI surface, not the desktop-app surface — and don't claim the CLI is more capable

Claude Code now runs across several surfaces (CLI, Claude desktop app, web, IDE) that all drive the *same* agent. The tutorial teaches the **CLI** surface specifically. We frame the reason as **"the CLI is a building block; the desktop app is a terminus"** — the CLI itself can be piped, scripted, scheduled, and composed into other tools (`cat draft.md | claude -p | pbcopy`), whereas the desktop app is a destination you stop at. We deliberately do **not** argue that the CLI is more *capable*, because the desktop app can run scripts and pipes internally too — that argument would be both losable and dishonest.

## Considered options

- **"The CLI can do more than the desktop app."** Rejected: false. The desktop app's embedded Claude Code runs the same Bash tool, so it can run scripts and pipes internally. Resting the book on a capability gap that doesn't exist would get caught.
- **Just declare scope ("this book teaches the CLI") without answering "why."** Rejected: a desktop-app-aware reader reads this as dodging, and the book's credibility rests on not dodging.
- **Building block vs terminus + a forward bet (chosen).** The honest, defensible line: the CLI is composable (a building block); the desktop app is a terminus. The deeper motivation — understanding the underlying layer, and a bet that AI is dissolving the walls between roles so "wiring AI into anything" becomes general literacy — is the author's forward-looking view, not a present-day fact.

## Consequences

- **Preface** names the desktop app proactively ("you may have heard the desktop app runs Claude Code too — same agent, another door; this book walks through the terminal door because…"), reframes the book's three "walls" as walls between *Claude.ai web chat* and *the Claude Code agent* (which the desktop app also climbs), and carries only the beginner-graspable "building block vs terminus" metaphor — deferring the payoff to chapter 10.
- The preface line that called Claude Code "a CLI agent… runs in your terminal, not the web" is now inaccurate and must be corrected to "it has several doors; this book takes the terminal one."
- **Chapter 10** pays off the metaphor: every door in that chapter (hooks, MCP, subagents, `claude -p` in cron/CI) hangs off the CLI and cannot live on the terminus. It closes with one restrained, explicitly-flagged-as-opinion paragraph on role convergence — the off-ramp must not end on grand speculation.
- The vocabulary needed for the full argument (`claude -p`, pipes, cron, hooks, MCP) is not available to the reader in the preface, which is *why* the argument is split: metaphor early, payoff late.
- `CONTEXT.md` no longer defines Claude Code *as* "the CLI"; the CLI is one surface among several.
