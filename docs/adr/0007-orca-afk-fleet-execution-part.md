# Teach orca + afk-fleet as a Part 3 (执行篇) — one hands-on chapter on running the backlog, superseding ADR-0006's doors-only decision

**Supersedes [ADR-0006](./0006-orca-afk-fleet-doors.md).** ADR-0006 admitted orca and afk-fleet as concept-level *doors* on the off-ramp (named, not taught). This ADR overturns that: the maintainer decided to **teach** them, as a new **执行篇 / Part 3** — one combined hands-on chapter. ADR-0006's framing (the ADR-0003 resolution, the narrative arc) is otherwise sound and is carried forward here; only its "doors, not chapters" verdict is reversed. No door content ever landed in the off-ramp, so this is a change of plan, not a revert of shipped prose.

## Why teach it now

[ADR-0001](./0001-tutorial-scope.md) set the destination at "write a multi-file skill" and warned "each branch we'd add would dwarf the tutorial." [ADR-0005](./0005-engineering-skills-part.md) then admitted a 进阶篇 (Part 2) teaching the `mattpocock/skills` *planning* pipeline, on the reasoning that it is the **natural continuation of the destination**: the reader who can build and share a skill next points it at real work. This ADR extends the book one movement further, on the *same* reasoning.

Part 2 ends with a **backlog** — a pile of `ready-for-agent` issues, dependency-ordered (`/grill-with-docs` → `/to-spec` → `/to-tickets`). The immediate, unavoidable next question is: *who implements that backlog, and where do they run?* ADR-0006 answered it by **naming** two doors. But naming is unsatisfying precisely here, because the reader is holding a real backlog they now want worked — the book walks them to the edge of execution and stops. Part 2 already crossed the line from "name the suite" to "teach the suite" (that was ADR-0005's whole move); Part 3 makes the same move for execution.

What keeps this from "dwarfing the tutorial" (ADR-0001's test) is the same ceiling ADR-0005 used: the reader **uses** orca and afk-fleet as tools — installs them, runs them against the backlog they already produced — and does **not** learn to build them. And it is deliberately **one combined chapter**, not a multi-chapter part: orca and afk-fleet are two halves of a single story (the substrate and the consumer), so one chapter teaches both without the part sprawling.

## The ADR-0003 tension, resolved (carried from ADR-0006)

[ADR-0003](./0003-cli-not-desktop-app.md) committed the book to the CLI surface, framed as **"the CLI is a building block; the desktop app is a terminus"** — and the off-ramp's "Why the terminal / 为什么是终端" section pays that metaphor off. orca is a **desktop app**, so on its face it is the terminus ADR-0003 warns against.

It is not. orca is a third-party *orchestrator that runs CLI coding agents* — Claude Code, Codex, and others — in parallel, each in its own isolated git worktree. It does not replace the terminal building block; it is **built on top of it**. A desktop app whose entire job is to spawn and coordinate CLI agents is the building-block thesis *paying off*, not a competing destination you stop at. That makes orca the sharpest example the book has of the thesis: the reason to learn the composable CLI surface is that tools like orca can then assemble it into something larger.

ADR-0003's honesty rule still binds. The chapter must **not** argue orca proves the CLI is "more capable" than the desktop app (ADR-0003 rejected that as false and losable). The claim is narrower and true — orca is a terminus *made of* building blocks, possible only because the CLI is composable.

## afk-fleet: provenance and the authorization it teaches

Two things about afk-fleet the chapter must be upfront about:

- **Provenance.** Part 2 taught a *third-party* suite (`mattpocock/skills`). afk-fleet is the **maintainer's own** skill (`sunfmin/afk-fleet`), built on orca. The chapter says so plainly — the reader should know they are being shown the author's own tool, not a neutral standard.
- **A real-consequence authorization.** afk-fleet, run for real, **pushes to a remote and auto-merges green PRs to `main` unattended**. That is the most consequential action the whole book asks the reader to take. The chapter must (a) have the reader run `/afk-fleet --plan` (a dry run that dispatches and merges nothing) first, (b) spell out exactly what the reader is turning on before they turn it on, and (c) name the gate that stands between a worker's PR and `main` (CI where it exists; for a prose repo like this book, an independent adversarial-verification pass). Auto-merge is presented as something the reader consciously authorizes, never a default.

## The narrative arc

Ordered orca-then-afk-fleet, because each builds on the one above it:

1. **`mattpocock/skills`** (Part 2) produces the backlog: `/grill-with-docs` → `/to-spec` → `/to-tickets` publishes `ready-for-agent` issues in dependency order.
2. **orca** supplies the substrate: it creates the isolated parallel git worktrees (one per issue, each on its own branch) a coding agent can work in without stepping on any other.
3. **afk-fleet** consumes the backlog: a launcher spawns disposable ticks; each tick dispatches worktree-isolated Claude Code workers — one per `ready-for-agent` issue — gates each, and merges the green PRs unattended.

This repo is itself the worked example: the `docs/agents/afk-fleet.md` per-repo config, and Part 3 itself, were produced by exactly this loop.

## Considered options

- **Keep ADR-0006's doors-only decision (status quo).** Rejected: the book walks the reader right up to a published backlog and then only *names* how to work it. The maintainer asked for taught chapters — the same reason ADR-0005 turned the Part 2 door into taught chapters.
- **A multi-chapter Part 3 (orca, afk-fleet, gating, merge policy each its own chapter).** Rejected: *this* is the branch ADR-0001 says would dwarf the tutorial. Claim locks, CI/adversarial gates, and unattended-merge policy are each their own lesson; taught exhaustively they are a different book.
- **Two chapters, one per tool (as ADR-0005 did for the five skills).** Reasonable, but orca and afk-fleet are the substrate and the consumer of *one* execution story; splitting them scatters a single arc across two files and re-raises the "does this dwarf the book" worry. The maintainer chose one combined chapter.
- **One combined hands-on chapter, inserted before the off-ramp (chosen).** The reader installs orca and afk-fleet and runs their own Part 2 backlog through them. Smallest footprint that still *teaches* rather than *names*.

## Consequences

- **One new chapter.** A single Part 3 (执行篇) chapter — `16-orchestrate-fleet` in both `zh/` and `en/` — teaches orca (parallel worktree agents) then afk-fleet (the unattended fleet that works the backlog). New narrative: build (6–8) → practice (9) → share (10) → plan real work (11–15) → **run the backlog (16)** → off-ramp (17).
- **Renumbering ripple.** `16-next-steps.md` → `17-next-steps.md` in both `zh/` and `en/` (via `git mv`); the in-chapter title `第 16 章 / Chapter 16` → `17`; the STATUS.md row slug; the README chapter lists; and inbound cross-links. Chapter 15's "Next" now leads into Part 3 (chapter 16), no longer straight to the off-ramp; the preface's forward reference ("what this building block can build … chapter 16 reflects") moves to chapter 17.
- **Off-ramp reframed.** Since orca and afk-fleet are now *taught*, the off-ramp must not list them as doors; its recap gains a Part 3 line ("you orchestrated agents across worktrees and ran an unattended fleet"), mirroring ADR-0005's "next-steps reframed" consequence. The other doors (Anthropic docs, the rest of `mattpocock/skills`, hooks, MCP, subagents, "Why the terminal") stay — and "Why the terminal" may cite orca as its strongest example, bound by ADR-0003's honesty rule.
- **New prerequisites, softly.** Part 3 requires installing **orca** (a desktop app, from onorca.dev) and **afk-fleet** (`npx skills add sunfmin/afk-fleet`). Both happen just-in-time inside chapter 16 — not backfilled into chapter 2. GitHub + `gh` are already established by ADR-0004's chapter 10; no new account gate.
- **Glossary additions.** `CONTEXT.md` gains a Part 3 section — the terms and conventions from ADR-0006 (`orca`, `afk-fleet`, `worktree`, `fleet`, all kept English, glossed once) plus `ADE`, `tick`, `launcher`, `worker`, and `backlog` — and its unit count (18 units, 0–17) and "destination" wording are updated. Product/command names stay English; umbrella concepts gloss on first use. The actual `CONTEXT.md` edit lands with the chapter.
- **Calibration honesty.** The new chapter carries a calibration header but is authored, not yet re-run end-to-end on a clean Mac (installing orca + authorizing a live fleet is not a clean-room step); its STATUS.md row says so, following the chapter 6/7 and Part 2 precedent.
- **ADR-0006 marked superseded**, pointing here.
