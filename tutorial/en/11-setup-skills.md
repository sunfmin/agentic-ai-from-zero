# Chapter 11 — Install the Engineering Skills, Set the Repo's Protocol

_Last calibrated: 2026-06, against Claude Code v2.x_

> 🚩 **Part 2 starts here.** The first ten chapters took you from zero to writing and sharing a multi-file skill. Part 2 changes the goal: instead of teaching you to *build* a skill, it teaches you to *use* a set of professional skills someone else built — Matt Pocock's `mattpocock/skills`. They turn Claude Code from a coding partner into a project-management partner: decisions, PRDs, tickets, and code architecture, all managed from inside Claude Code.
>
> Part 2 assumes you have the GitHub account and `gh` from chapter 10. Everything else we install as we go.

In chapter 8 you used a skill **someone else wrote**: the built-in `/skill-creator`. You didn't read its `SKILL.md` — you just typed `/skill-creator` and used it. The five skills in Part 2 work the same way: you reach them by typing `/command`, exactly like `/skill-creator`. The only difference is they aren't bundled with Claude Code, so you install them first.

This chapter does three things: figure out **why** you'd want this set, **install** it, and run the first and most important one — `/setup-matt-pocock-skills` — which lays down the "protocol" every later skill in your repo will follow.

## What this set of skills is fixing

The author boils their origin down to a few "most common AI-coding train wrecks." You've probably hit all of them:

1. **"The agent didn't build what I wanted."** You thought it understood you; what it built drifted. The root cause is **misalignment**. The fix: make the agent **grill** you about what you want before any code is written — that's `/grill-with-docs` (chapter 12).
2. **"The agent is way too verbose."** Early in a project, you and the agent don't speak the same jargon, so it uses 20 words where 1 would do. The fix: build a **shared language** (a glossary) so decisions and code derive from the same vocabulary — also built into `/grill-with-docs`.
3. **"The code doesn't work."** Even aligned, the agent can produce junk. The root cause is **too few feedback loops**. The fix: types, tests, red-green-refactor — the suite's `/tdd` and `/diagnosing-bugs` (not covered here; chapter 16 gives you the door).
4. **"We built a ball of mud."** Agents accelerate coding, and therefore accelerate **entropy**; the codebase gets harder to change. The fix: periodically fish out the "shallow modules" and deepen them — that's `/improve-codebase-architecture` (chapter 15).

Part 2 focuses on five of these skills. The first four form a **planning pipeline**; the last is a separate entry point for existing code:

```
fuzzy idea
   │  /setup-matt-pocock-skills   ← once, lays down the repo protocol (this chapter)
   ▼
repo with a protocol
   │  /grill-with-docs            ← grills the idea into decisions (chapter 12)
   │   → CONTEXT.md, docs/adr/
   ▼
repo with a paper trail
   │  /to-spec                    ← synthesizes a PRD (chapter 13)
   │   → one PRD issue
   ▼
repo with a PRD
   │  /to-tickets                 ← slices into grabbable issues (chapter 14)
   │   → a pile of ready-for-agent issues
   ▼
issues an agent can pick up and build

(a separate path)
existing code  ──  /improve-codebase-architecture  ──→  architecture report + deepening (chapter 15)
```

> 💡 **user-invoked vs model-invoked.** Skills in the suite split two ways. **user-invoked** ones run only when you type `/command` (their `SKILL.md` says `disable-model-invocation: true`) — all five here are this kind. **model-invoked** ones can also be reached for by Claude on its own when the task fits. The benefit of the split: a "heavy" operation like `/grill-with-docs`, which touches a bunch of files, is always something *you* start — it never fires on its own.

## Install the suite

The suite installs through an installer called skills.sh. Run this in your terminal (in your own shell, **not** in Claude's prompt):

> 🛠 Try it
>
> Type: `npx skills@latest add mattpocock/skills`
>
> You should see: an interactive list of every skill in the repo, letting you pick which to install and onto which agent (Claude Code, etc.).
>
> **Just select all of them.** Simplest and safest — don't cherry-pick, for the reason in the note below.

> ⚠️ **Why you can't install just a few.** What Part 2 actually teaches you to use is `setup-matt-pocock-skills` plus these four: `grill-with-docs`, `to-spec`, `to-tickets`, `improve-codebase-architecture`. But these `/command` skills delegate to a set of model-invoked "parts" skills underneath — `grill-with-docs` calls `grilling` and `domain-modeling`, and `improve-codebase-architecture` also calls `codebase-design`. Install only the front ones and skip the parts, and the top-level skills misbehave (an incomplete grill, no report). So select all — don't cherry-pick.

Confirm they landed:

> 🛠 Try it
>
> Type: `ls ~/.claude/skills/`
>
> You should see: alongside the skills you wrote in earlier chapters (e.g. `review-writing`), the newly installed folders.
>
> Then peek at the top of one: `head -5 ~/.claude/skills/setup-matt-pocock-skills/SKILL.md`
>
> You should see: frontmatter with `name`, `description`, and `disable-model-invocation: true` — confirming the "user-invoked" point above.

> ⚠️ After installing, **start a new `claude` session** to pick up the new skills. An old session won't see what you just installed — same rule as the chapter 8 debug checklist's "open a new session after changing a skill."

## Spin up a practice repo

Part 2 is **fully hands-on**: you'll run the whole pipeline on a real repo and publish real GitHub issues. To avoid messing with anything you already have, we'll spin up a dedicated practice repo.

It carries chapters 11–14. What you build is up to you — the value of grilling later comes from it forcing you to answer questions about **your own idea**. Pick something small you actually half-want to make (the kind you can state in one sentence). The rest of this book uses "**a reading-list app that tracks things I want to read**" as the **example**, so I can tell you roughly what you'll see; substitute your own idea.

> 🛠 Try it
>
> In your terminal:
>
> > ```
> > mkdir ~/reading-list && cd ~/reading-list
> > claude
> > ```
>
> (Name the folder whatever you like; better, after your own idea.)
>
> You should see: Claude Code starting in an **empty directory**. That blank page is exactly the starting point we want.

## Run `/setup-matt-pocock-skills`

This is the **first** skill you run in a new repo, and you run it **once per repo**. It writes no business content — it does one thing: lay down an "agent protocol" for the repo, telling every later skill three things — where issues go, what triage labels to use, and where the project's terminology lives.

> 🛠 Try it
>
> In Claude's prompt, type: `/setup-matt-pocock-skills`
>
> You should see: Claude first scan the current directory (empty), then ask you three things **one at a time**, each with a short "what this is / why it's needed" explainer and a recommended default:
>
> 1. **Which issue tracker?** — GitHub / GitLab / local markdown / other. You've been on GitHub + `gh`, so pick **GitHub**. (It may also ask whether PRs count as a request surface; for a practice project, answer no.)
> 2. **What triage labels?** — five canonical roles: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. Take the defaults.
> 3. **How are domain docs laid out?** — single-context (one `CONTEXT.md` + `docs/adr/` at the repo root) or multi-context. For a practice project, pick **single-context**.

Once you've answered, it shows you what it's about to write before saving. Approve, then look at what it built:

> 🛠 Try it
>
> Type: `ls -R . docs 2>/dev/null` (or just ask Claude to "list the files you just created")
>
> You should see roughly:
>
> > ```
> > CLAUDE.md                       ← now has a "## Agent skills" block
> > docs/agents/issue-tracker.md    ← "issues live in GitHub, via the gh CLI"
> > docs/agents/triage-labels.md    ← the five triage roles
> > docs/agents/domain.md           ← how to read CONTEXT.md / ADRs
> > ```
>
> Glance at `CLAUDE.md`: `cat CLAUDE.md`. You should see an `## Agent skills` section whose three subsections each point, in one line, at the three files above.

> 💡 If the directory had neither `CLAUDE.md` nor `AGENTS.md`, Claude asks you **which one to create** — it won't decide for you. Once it exists, it only adds an `## Agent skills` block; it leaves your other content alone.

## Why this step is the "junction box"

`/setup-matt-pocock-skills` does no real work itself — no business code, no issues filed. But it's the junction box that **every** later skill plugs into:

- When `/to-spec` and `/to-tickets` need to file an issue, they read `docs/agents/issue-tracker.md` and so know to call `gh issue create` instead of asking you "where?"
- When they label an issue "an agent can pick this up now," they read `docs/agents/triage-labels.md` and apply `ready-for-agent` rather than inventing a label.
- Before `/grill-with-docs` and `/improve-codebase-architecture` explore code, they read `docs/agents/domain.md` and so know where the glossary lives.

Skip this step and every later skill has to **ask you all over again** "where do issues go, what label do I use," or just guess. Five minutes once saves twenty repeated conversations later — that's its leverage.

## Save and publish this step

You already know the git/GitHub moves from chapter 10. Have Claude check in this protocol and push it — and set up the GitHub remote for this practice repo at the same time, so `/to-spec` and `/to-tickets` have somewhere to file issues.

> 🛠 Try it
>
> In the prompt, tell Claude:
>
> > Commit this, then create this repo on GitHub and push it.
>
> You should see: Claude run `git init` / `git add` / `git commit`, ask you about visibility (public/private) and the repo name, then use `gh repo create ... --push` to push it to GitHub. It **confirms the risky choice** (public vs private) before creating — it won't default to public and run.

You now have a repo that has a **protocol, is on GitHub, but contains not a line of business content**. The next chapter starts pouring "decisions you've thought through" into it.

## Recap

- Part 2 teaches you to **use** a ready-made set of professional skills, not write them — same posture as using `/skill-creator` in chapter 8.
- All five skills are **user-invoked**: they run only when you type `/command`; they never surface on their own.
- Install: `npx skills@latest add mattpocock/skills`, **select all** (these skills depend on lower-level `grilling` / `domain-modeling` / `codebase-design` — don't cherry-pick just the ones we teach); **start a new session** afterward.
- Run `/setup-matt-pocock-skills` **once per repo** to lay down the protocol (issue tracker / triage labels / domain docs), written into `CLAUDE.md` + `docs/agents/`.
- That protocol is the **junction box** every later skill plugs into — done once, it removes countless "where do issues go, what label?" round-trips.

## Next

[Chapter 12 — *Grill a Fuzzy Idea into Decisions*](./12-grill-with-docs.md). You'll run `/grill-with-docs` against your one-line idea and get grilled, squeezing it into a string of concrete decisions — which get written into `CONTEXT.md` and ADRs as you go.
