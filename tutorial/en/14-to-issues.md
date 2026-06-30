# Chapter 14 — Slice the PRD into Grabbable Issues

_Last calibrated: 2026-06, against Claude Code v2.x_

Last chapter you got a PRD (one GitHub issue). But a PRD is a **panorama** — an agent staring at it doesn't know where to bite. This chapter slices the panorama into small issues that can each be **grabbed and worked independently**. The skill is `/to-issues`.

This chapter has one core concept, but it's one of the most important judgments in this whole workflow: **how to slice**.

## Vertical slices, not horizontal ones

There are two ways to slice a feature.

**Horizontal slicing** (by layer) — finish all the data structures, then all the interfaces, then all the UI, then test it all at the end:

```
Slice A: all the schema      ← on its own, demonstrates nothing
Slice B: all the API         ← on its own, demonstrates nothing
Slice C: all the UI          ← can't start until A and B are done
Slice D: all the tests       ← feedback comes last
```

The problem: each slice **demonstrates nothing on its own**, and you only learn whether the whole path works at the very end.

**Vertical slicing** (tracer bullets) — each slice cuts **end-to-end through every layer**: narrow, but complete:

```
Slice #1: can add one item (schema + interface + UI + test, just this one path)  ← done = demoable!
Slice #2: can list all items (cuts through every layer too)                       ← done = demoable!
Slice #3: can mark one item done                                                  ← done = demoable!
```

`/to-issues` slices the **latter** way. Three rules, that's it:

- each slice runs **one narrow path from end to end** (touching schema, interface, UI, tests a little);
- each slice, once done, **can be demoed or verified on its own**;
- any "prefactoring" needed goes first — "make the change easy, then make the easy change."

> 💡 Why this matters: vertical slices guarantee that every time an issue merges, the repo has **advanced by a visible increment**, not a half-built thing. And independent slices can be **grabbed in parallel** by multiple agents.

## Hands-on: slice your PRD

`/to-issues` uses the PRD in the current conversation; you can also hand it the PRD issue number directly.

> 🛠 Try it
>
> In the prompt, type (replace `#1` with last chapter's PRD issue number; if you're still in the same session, a bare `/to-issues` works too):
>
> > `/to-issues #1`
>
> You should see: Claude read that PRD (maybe scanning the repo for "prefactoring" opportunities), then hand you a **numbered slice list**. Each slice is tagged with:
>
> - **Title**: one line on what this slice does;
> - **Blocked by**: which slices must finish first (or "can start immediately");
> - **User stories covered**: which PRD stories it addresses.

## It quizzes you back

The slice list isn't filed the moment you've looked at it. `/to-issues` first **asks you a few things** to confirm the slicing is right:

- Is the granularity right? (too coarse? too fine?)
- Are the dependencies correct? (who really must wait on whom)
- Should any be merged, or split further?

> 🛠 Try it
>
> Answer it. If a slice is too big (e.g. "the entire tagging system"), have it split further; if two are really one thing, have it merge them. Go a few rounds until you're happy with the list.
>
> You should see: Claude adjust the list per your feedback and hand it back for confirmation — like chapter 12's grilling, iterating until you nod.

## Publishing: in dependency order

Once you nod, Claude files each slice as a GitHub issue, **in dependency order** (blockers first), so later issues can reference real issue numbers in their "Blocked by." Each issue uses a fixed template:

| Section | What it holds |
|---|---|
| **Parent** | points at the PRD issue |
| **What to build** | the slice's end-to-end behavior (**no file paths** — they go stale fast) |
| **Acceptance criteria** | a checkbox list, each item verifiable |
| **Blocked by** | points at the blocking issue, or "None — can start immediately" |

They all get the `ready-for-agent` label (these slices are meant for an AFK agent). `/to-issues` does **not** close or modify the parent PRD issue.

> 🛠 Try it
>
> Let it publish.
>
> You should see: a string of new issues created (numbered on from last chapter's PRD), each referencing the parent PRD, listing acceptance criteria, and tagged with its blocker. Open one — it's specific enough that an agent can start without asking anyone anything.

> 💡 On a real project, there are slices you'll want to **review yourself** rather than hand to an agent — typically the leading slice that establishes the conventions everything else builds on. See [`BOOTSTRAP-CASE-STUDY.en.md`](../../BOOTSTRAP-CASE-STUDY.en.md): that session sliced this book into 11 slices, and **the leading slice was marked "needs a human to review at merge time,"** with the rest handed to agents. You can have `/to-issues` mark it that way too.

## The whole pipeline, now a closed loop

Step back and look at what these four chapters did:

```
fuzzy idea
  → /setup-matt-pocock-skills   (ch 11: lay down the protocol)
  → /grill-with-docs            (ch 12: grill into decisions + CONTEXT.md/ADR)
  → /to-prd                     (ch 13: synthesize into a PRD issue)
  → /to-issues                  (ch 14: slice into ready-for-agent issues)
  → a pile of issues an agent can build straight away
```

Every step **narrows the degrees of freedom**: idea → decisions → PRD → issues. Every step leaves a visible artifact and a traceable commit. You may have typed only a few sentences total (a lot of replies are just "go with the recommendation"), but the output is a spec an absent agent can pick up and turn into a string of PRs.

> 💡 This pipeline works for **any project** — not just code. This book itself was planned this way (a bilingual tutorial); `BOOTSTRAP-CASE-STUDY.en.md` is the full transcript.

## Recap

- `/to-issues` slices the PRD into **vertical slices** (end-to-end, demoable on their own), not horizontal by-layer slices.
- Prefactoring goes first: "make the change easy, then make the easy change."
- It **quizzes you** on granularity and dependencies, iterating until you're happy, then files issues **in dependency order**.
- Issue template: Parent / What to build (no file paths) / Acceptance criteria / Blocked by, tagged `ready-for-agent`.
- This closes the `setup → grill → prd → issues` loop: each step narrows freedom and leaves traceable artifacts.

## Next

[Chapter 15 — *Deepen a Codebase*](./15-improve-architecture.md). The first four chapters plan **new features**; the last chapter switches entry points, running `/improve-codebase-architecture` against **existing code** to find "shallow modules," produce a visual architecture report, and walk you through deepening one.
