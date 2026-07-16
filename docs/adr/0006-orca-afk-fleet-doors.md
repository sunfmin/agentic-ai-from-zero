# Admit orca + afk-fleet as concept-level off-ramp doors — orca runs CLI agents, reinforcing the building-block thesis instead of competing with it

> **⚠️ Superseded by [ADR-0007](./0007-orca-afk-fleet-execution-part.md).** This ADR decided to admit orca and afk-fleet as concept-level *doors* on the off-ramp. That decision was reversed before any door prose shipped: they are now **taught** as a Part 3 (执行篇) hands-on chapter. The ADR-0003 resolution and the narrative arc below are still accurate and were carried into ADR-0007; only the "doors, not chapters" verdict no longer holds. Kept for the decision trail.

[ADR-0001](./0001-tutorial-scope.md) set the tutorial's scope ceiling ("each branch we'd add would dwarf the tutorial itself"), and the off-ramp — **chapter 16, next-steps** — is where that ceiling is honoured openly: it **names** advanced doors (Anthropic docs, the rest of `mattpocock/skills`, hooks, MCP, subagents) and says "here's what's behind it, here's who it's for," without teaching any of them. This ADR admits two more such doors to that chapter: **orca** (`stablyai/orca`) and **afk-fleet** (`sunfmin/afk-fleet`), both as concept-level doors — named and explained, not taught as hands-on chapters.

This follows the precedent of [ADR-0004](./0004-git-content-scope.md): it admitted git/GitHub content because that content sat squarely on the book's destination (sharing the skill the reader built), while the *ceiling* stayed intact by keeping the treatment concept-level rather than command-by-command. The same test applies here. orca and afk-fleet are the natural continuation of the arc the book already walks — Part 2 (`mattpocock/skills`) teaches a reader to turn a fuzzy idea into a published `ready-for-agent` issue backlog; the obvious next question is "who works that backlog, and where do they run?" These two doors answer it. Admitting them as doors keeps ADR-0001's "each branch would dwarf the tutorial" line intact: the reader learns *that they exist and who they are for*, not how to operate them. That is the same posture the off-ramp already takes toward MCP, hooks, and subagents.

Note on numbering: the issue that requested this decision predates the [ADR-0005](./0005-engineering-skills-part.md) Part 2 restructure and referred to it as "ADR-0005" and to a "chapter 11" off-ramp. That restructure took the 0005 number and renumbered next-steps to chapter 16, so this record is **0006** and points at **chapter 16**. ADR numbers are immutable — the intent was "the next ADR after 0004, targeting the off-ramp," and this is it.

## The ADR-0003 tension, resolved

[ADR-0003](./0003-cli-not-desktop-app.md) committed the book to teaching the CLI surface, framed as **"the CLI is a building block; the desktop app is a terminus"** — and chapter 16's "Why the terminal / 为什么是终端" section pays that metaphor off. orca is a **desktop app**, so on its face it looks like exactly the terminus ADR-0003 warns against.

It is not. orca is a third-party *orchestrator that runs CLI coding agents* — Claude Code, Codex, and others — in parallel, each in its own isolated git worktree. It does not replace the terminal building block; it is **built on top of it**. A desktop app whose entire job is to spawn and coordinate CLI agents is the building-block thesis *paying off*, not a competing destination you stop at. This makes orca the strongest single example the book has of that thesis: the reason to learn the composable CLI surface is that tools like orca can then assemble it into something larger.

The ADR must state this framing so the chapter copy stays honest and on-thesis. ADR-0003's honesty rule still binds: the chapter must **not** argue orca proves the CLI is "more capable" than the desktop app (ADR-0003 rejected that line as false and losable). The claim is narrower and true — orca is a terminus *made of* building blocks, which is only possible because the CLI is composable.

## The narrative arc

The two doors are ordered **orca-then-afk-fleet**, and both sit **after** the `mattpocock/skills` door already on the off-ramp, because each builds on the one above it:

1. **`mattpocock/skills`** (the door already there) produces a ticket backlog: `/grill-with-docs` → `/to-prd` → `/to-issues` publishes `ready-for-agent` issues in dependency order.
2. **orca** supplies the substrate: it creates the isolated parallel git worktrees (one per issue, on its own branch) that a coding agent can work in without stepping on any other.
3. **afk-fleet** consumes the backlog: it dispatches worktree-isolated Claude Code workers — one per `ready-for-agent` issue — gates each on the issue's acceptance criteria (plus, for a prose repo like this one, an independent adversarial-verification pass), and merges the green PRs unattended.

So the reading order is orca first (the substrate afk-fleet's workers run in), then afk-fleet (the consumer that puts the substrate and the backlog together). This repo is itself the worked example: the `docs/agents/afk-fleet.md` per-repo config and this very ADR were produced by that loop.

## Considered options

- **Leave the off-ramp as-is (status quo).** Rejected: the book walks the reader right up to a published issue backlog in Part 2 and then goes quiet on the obvious next step — actually working that backlog. Two real, name-able tools close that gap, and the off-ramp exists precisely to name doors like these.
- **Teach orca and afk-fleet as hands-on chapters (a Part 3).** Rejected: this is the branch ADR-0001 says will dwarf the tutorial. Parallel worktree orchestration, claim locks, CI/adversarial gates, and unattended merge policy are each their own lesson, and orca is a separate product with its own install and UI surface. That is a different book.
- **Admit only afk-fleet and skip orca.** Rejected: afk-fleet's workers run *in orca's worktrees* — naming the consumer without naming the substrate it runs on leaves the door half-open and the arc incoherent. And skipping orca would forfeit the cleanest payoff of ADR-0003's building-block thesis.
- **Admit both as concept-level doors on chapter 16, ordered orca-then-afk-fleet (chosen).** Matches the off-ramp's established "what's behind it / who it's for" shape, preserves ADR-0001's ceiling, resolves the ADR-0003 tension explicitly, and follows the arc the book already set up.

## Consequences

- **Two doors, not two chapters.** chapter 16 (`tutorial/zh/16-next-steps.md` and `tutorial/en/16-next-steps.md`) gains an orca door and an afk-fleet door, each in the off-ramp's existing "What's behind it / Who it's for" form. The chapter prose is a **separate ticket**; this ADR is the decision only.
- **Door order and placement.** orca before afk-fleet, both placed after the `mattpocock/skills` section (the door that produces the backlog afk-fleet consumes). The chapter edit must keep the zh and en sides in parity — both doors, same order, in both files.
- **The "Why the terminal" section gains its strongest example.** orca — a whole product built on running CLI agents in parallel — is the sharpest illustration of "the CLI is a building block." The chapter edit may cite it there, bound by ADR-0003's honesty rule (no false capability-gap claim).
- **Bilingual term conventions** for the new proper nouns, per the CONTEXT.md policy (command-like / product names stay English; umbrella concepts may gloss on first use). The chapter-edit ticket applies these to `CONTEXT.md` and the prose — this ADR only records them:
  - **`orca`** — product name (`stablyai/orca`). Keep English, lowercase, never translated — like `git`, `gh`, and `mattpocock/skills`. Distinct from the animal; refer to the repo as `stablyai/orca` on first mention.
  - **`afk-fleet`** — tool / skill name (`sunfmin/afk-fleet`). Keep English, lowercase, hyphenated, never translated. "AFK" = away-from-keyboard; gloss the expansion once on first use, keep `afk-fleet` as the canonical form.
  - **`worktree`** — git terminology (a `git worktree`: a second working copy of one repo on its own branch). Keep English to match what git and orca print; gloss on first use (worktree ≈ 独立工作副本 / 隔离工作区), then use English.
  - **`fleet`** — umbrella concept: the standing set of parallel workers afk-fleet runs. Keep English as the canonical form; gloss on first use (fleet ≈ 一支并行工作的 agent 舰队). _Avoid_: 集群, 车队.
- **No chapter prose changed here.** This ticket adds only `docs/adr/0006-orca-afk-fleet-doors.md`. CONTEXT.md and chapter 16 are untouched; they move under the follow-up chapter-edit ticket.
