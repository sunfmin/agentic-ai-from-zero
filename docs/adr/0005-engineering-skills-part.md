# Admit an engineering-skills 进阶篇 — using a professional skill suite to manage real projects, beyond skill-authoring

[ADR-0001](./0001-tutorial-scope.md) set the tutorial's destination at "writing a multi-file Claude Code skill," and warned that "each branch we'd add would dwarf the tutorial itself." [ADR-0004](./0004-git-content-scope.md) then admitted git/GitHub content because it served a job sitting squarely on that destination (sharing the skill the reader built). This ADR extends the book one step further: a **进阶篇 (Part 2)** that teaches Matt Pocock's open-source engineering skill suite (`mattpocock/skills`) as a project-management workflow.

This is a deliberate expansion of ADR-0001's scope ceiling, on the same reasoning ADR-0004 used: it is the **natural continuation of the destination**. The reader who finishes Part 1 can build *and share* a skill. The next thing a reader does with that ability is point it at real work — and the suite is the off-the-shelf answer for that. Part 1's chapter 11 (next-steps) already names this suite as a "door"; the root `BOOTSTRAP-CASE-STUDY.md` already documents a full real session using four of the five skills. The 进阶篇 turns that door into taught chapters.

What keeps this from "dwarfing the tutorial" (ADR-0001's test): the reader **does not learn to build these skills**, only to *use* five of them as `/commands` — the same posture chapter 8 takes toward the built-in `/skill-creator`. The suite's internal design (its sub-skills, its vocabulary) is consumed, not authored.

## The five skills taught

In order, they form one planning pipeline plus one independent entry point:

1. `/setup-matt-pocock-skills` — one-time per-repo setup: picks the issue tracker, the triage-label vocabulary, and the domain-doc layout; writes a `## Agent skills` block + `docs/agents/*.md` that every other skill reads.
2. `/grill-with-docs` — a relentless one-question-at-a-time interview (`/grilling`) fused with domain modeling (`/domain-modeling`): turns a fuzzy idea into concrete decisions, recording terms in `CONTEXT.md` and hard-to-reverse choices as ADRs *inline*.
3. `/to-prd` — no interview; mechanically synthesizes the conversation into a PRD and publishes it as a `ready-for-agent` issue.
4. `/to-issues` — slices a PRD into tracer-bullet **vertical slices** (end-to-end, not layer-by-layer) and publishes them as grabbable issues in dependency order.
5. `/improve-codebase-architecture` — a separate entry point for *existing* code: scans for shallow→deep "deepening opportunities," renders a visual HTML report, then grills through a chosen candidate.

## Considered options

- **Keep it as the next-steps "door" only (status quo).** Rejected: the reader is told the suite exists and pointed at the upstream repo + case study, but never shown *how* to use any of it. The user explicitly asked for taught chapters.
- **Walkthrough/reading chapters annotating `BOOTSTRAP-CASE-STUDY.md`.** Rejected: passive, and out of step with the book's "read-and-do" style (the 🛠 试一试 box is the book's signature).
- **A handful of grouped chapters (e.g. setup+grill in one, prd+issues in one).** Reasonable, but the user chose one chapter per skill so each gets room to teach "what it is + how to use it" thoroughly.
- **Five hands-on chapters, one per skill, inserted before next-steps (chosen).** Install folds into the setup chapter. The reader runs the pipeline on their own real repo and publishes real issues; chapter 15 runs against a shipped sample codebase so even non-coders get a real HTML report.

## Consequences

- **Five new chapters.** `11-setup-skills`, `12-grill-with-docs`, `13-to-prd`, `14-to-issues`, `15-improve-architecture` are inserted. New narrative: build (6–8) → practice (9) → share (10) → **use the suite on real work (11–15)** → off-ramp (16).
- **Renumbering ripple.** `11-next-steps.md` → `16-next-steps.md` in both `zh/` and `en/` (via `git mv`); the in-chapter title `第 11 章 / Chapter 11` → `第 16 章 / Chapter 16`; the STATUS.md row slug; the README chapter lists; and inbound cross-links. **Critically:** the preface pointer ("这块积木将来能搭成什么，第 11 章会讲 / what this building block can build, chapter 11 explains") and chapter 10's "下一章 / Next" pointer (which called next-steps "the last chapter / off-ramp") both refer to numbering that moves — they must be repointed. Chapter 10's "Next" now leads into the 进阶篇 (chapter 11), no longer into the off-ramp.
- **Next-steps reframed.** The "engineering-skills workflow" section in next-steps was an *unopened* door; once the 进阶篇 teaches it, that section is rewritten to point at the parts of the suite the book still does **not** teach (`/tdd`, `/triage`, `/diagnosing-bugs`, `/handoff`, `ask-matt`) plus the upstream repo. The other doors (hooks, MCP, subagents, official docs, "why the terminal") stay.
- **New prerequisite, softly.** The 进阶篇 requires installing the suite (`npx skills@latest add mattpocock/skills`). This happens just-in-time inside chapter 11 — **not** backfilled into chapter 2. GitHub + `gh` are already established by ADR-0004's chapter 10, so no new account gate is introduced.
- **A sample-project fixture ships.** `tutorial/sample-project/` — a tiny, readable, build-free codebase with a deliberate shallow-module deepening opportunity — is added so every reader can run `/improve-codebase-architecture` and see a real report regardless of whether they have their own code. It is language-neutral and shared by both `zh/` and `en/` chapters, mirroring how `tutorial/skills/` is shared.
- **Glossary additions.** `CONTEXT.md` gains an engineering-skills section (engineering skill suite, user-invoked vs model-invoked, PRD, issue, triage label, vertical slice / 垂直切片, deep / shallow module, seam, sample project, and the five `/command` names kept in English) and its stale unit count and "destination" wording are updated. `CONTEXT.md` remains a glossary — no implementation detail.
- **Calibration honesty.** The five new chapters carry a calibration header but were authored, not yet re-run end-to-end on a clean Mac; their STATUS.md rows say so (following the chapter 6/7 "partial / pending" precedent).
