# Chapter 13 — Synthesize Decisions into a PRD

_Last calibrated: 2026-06, against Claude Code v2.x_

Last chapter you got grilled, and the decisions were finalized and recorded (`CONTEXT.md` + ADRs). This chapter **synthesizes those decisions into a PRD** (product requirements document) and files it as a GitHub issue. The skill is `/to-prd`.

The most counterintuitive thing about this chapter: **`/to-prd` asks you no questions.** It's designed to "not interview the user — just synthesize what's already been discussed." Why, below.

## What it does

`/to-prd` takes "the context of the current conversation + the repo's current state (`CONTEXT.md`, ADRs, existing code)" and produces a fixed-structure PRD, filed as an issue with the `ready-for-agent` label. It pauses to confirm exactly **one** thing with you — the seam, below.

> 💡 **Best to fire `/to-prd` in the same session, right after the grill** — the context is fullest. But even if you closed it and opened a new session, that's fine — last chapter's decisions already live in `CONTEXT.md` and the ADRs, and `/to-prd` reads them first. This is the payoff of recording as you go: the decisions don't depend on one conversation still being open.

## The one thing it pauses to ask: the seam

Before writing the PRD, `/to-prd` sketches which **seams** it plans to test the feature at, and shows you for confirmation.

> 💡 **seam** is a borrowed word: a place in the code where you can swap out behavior without editing it in place — i.e. where you hang tests and inject fakes. Chapter 15 covers this word in full. Here you only need to know `/to-prd` prefers to **open few seams**. Its rule is "prefer existing seams, pick the highest one, fewer is better — ideally just one." Fewer seams means tests concentrate and changes concentrate.

> 🛠 Try it
>
> In the repo (ideally continuing last chapter's session), type: `/to-prd`
>
> You should see: Claude first explore the repo, read `CONTEXT.md` and the ADRs, then show you **which seam** it plans to test the feature at and ask "does this match your expectations?" Glance at it and answer "yes" or correct it.

## What the PRD looks like

Once the seam is confirmed, Claude writes the PRD against a fixed template. Seven sections:

| Section | What it holds |
|---|---|
| **Problem Statement** | the problem, from the user's perspective |
| **Solution** | the solution, from the user's perspective |
| **User Stories** | a long list of "As a &lt;who&gt;, I want &lt;what&gt;, so that &lt;benefit&gt;," meant to be **exhaustive**, covering every aspect |
| **Implementation Decisions** | which modules to build/change, their interfaces, architectural decisions, schema, API contracts — but **no specific file paths or code** |
| **Testing Decisions** | what makes a good test (test external behavior only), which modules get tested, any existing tests to model on |
| **Out of Scope** | what it explicitly **won't** do — defining by exclusion to cut future bickering |
| **Further Notes** | anything else |

> 💡 Note it writes **no file paths or code snippets** — those go stale fast. The one exception: if earlier exploration produced a snippet more precise than prose (a state machine, a schema, a type), it can be inlined, but trimmed to the decision-carrying lines — not a working demo.

When it's written, it publishes the PRD as a GitHub issue with the `ready-for-agent` label — meaning "this is specific enough that an absent agent can pick it up and start."

> 🛠 Try it
>
> Let it continue (you don't answer anything further).
>
> You should see: Claude call `gh issue create` to file an issue and hand you a link (something like `https://github.com/<you>/<repo>/issues/1`). Open it — all seven sections present, a long list of user stories, each using the terminology pinned down in `CONTEXT.md`.

> 💡 **A small detail: it backfills labels itself.** Last chapter `/setup` only **wrote down** "use these five triage labels" in `docs/agents/triage-labels.md`; the GitHub repo itself hadn't actually created those labels. When `/to-prd` files the issue, it calls `gh label list`, finds them missing, and **creates** the missing ones with `gh label create` before filing — you don't `gh label create` them one by one. That's it noticing a gap between protocol and reality and closing it.

## Why it doesn't interview you

Here's the core idea of this chapter:

> **`/to-prd` is a mechanical synthesis, not a creative act.**

It does no new design — all the design was **already done** in last chapter's grill. `/to-prd` just packs those decisions into the PRD template. That's why this step is fast and hard to get wrong.

Conversely: **if you skip the grill and run `/to-prd` straight away, you get a PRD that "sounds reasonable but is vague in every line"** — because the decisions were never made concrete. A hollow PRD isn't `/to-prd`'s fault; it's the fault of a grill that didn't go far enough.

This is also why it shouldn't interview you: interviewing is the grill's job. If `/to-prd` started asking you questions, it'd mean those questions belonged in the previous chapter. The two skills divide labor cleanly — one squeezes the decisions out, the other packs them up.

## Recap

- `/to-prd` **doesn't interview you**; it synthesizes the conversation + `CONTEXT.md` + ADRs into a PRD.
- The only thing it pauses to confirm is the **seam** (where to test): prefer existing, pick highest, fewer is better.
- The PRD is a fixed seven-section template, filed as a GitHub issue with `ready-for-agent`; on filing it backfills any missing triage labels.
- The PRD is **mechanical synthesis, not creation** — the design was done in the grill. The deeper the grill, the more concrete the PRD; a lazy grill yields a vague one.

## Next

[Chapter 14 — *Slice the PRD into Grabbable Issues*](./14-to-issues.md). A PRD is a panorama; an agent staring at it doesn't know where to start. You'll use `/to-issues` to slice it into end-to-end **vertical slices**, each one an agent can grab and build independently.
