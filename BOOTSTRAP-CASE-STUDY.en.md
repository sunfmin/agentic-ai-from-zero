# Bootstrapping a Claude Code project from scratch: a full session walkthrough

> _Last calibrated: 2026-05, against Claude Code v2.x_

## What this document is

On 2026-05-28, I started Claude Code in a **completely empty directory** with the goal of building a bilingual tutorial repository that teaches "Claude Code and skill-writing from zero." Over the course of one session, I invoked 4 skills, answered 14 design questions, made 2 commits, and shipped 1 PRD plus 11 independently-grabbable GitHub issues.

This document is a **step-by-step replay of that session, from start to finish** — exactly what I typed, which skill got invoked, how Claude responded, what each step produced, and why it mattered.

Who this is for:
- People who want to use AI to standardize the path from "fuzzy idea" to "executable task"
- People who've heard of Matt Pocock's engineering skills but don't know how to chain them together
- People who think "AI helps me write code" isn't enough — they want AI to help them **plan**

---

## Starting point

One Mac, one empty directory, Claude Code installed, and Matt Pocock's engineering skills already sitting in `~/.claude/skills/`.

```
$ pwd
/Users/sunfmin/Developments/agentic-ai-from-zero
$ ls
(empty)
```

What I wanted: **write a tutorial in this repo, taking a complete beginner (GUI-only, never touched a command line) all the way to writing multi-file Claude Code skills**. But all I had in my head was that single sentence — no outline, no directory layout, no decision about language, no clear sense of who the reader is, no OS decision.

Below is how Claude Code turned that one sentence into a PRD and 11 executable issues.

---

## The 4 skills used (in order)

1. **`/setup-matt-pocock-skills`** — gives the repo the "protocol" that agents need to follow (where issues live, which triage labels to use, how to read domain docs)
2. **`/grill-with-docs`** — **relentlessly interrogates** your rough idea with 14 specific questions, squeezing it into concrete decisions; meanwhile, it lands the decisions into `CONTEXT.md` and `docs/adr/`
3. **`/to-prd`** — synthesizes all the decisions into a PRD and publishes it as a GitHub issue
4. **`/to-issues`** — breaks the PRD into 11 independently-grabbable vertical slices and publishes each one as a GitHub issue

---

## Step 1: Give the repo an "agent protocol" — `/setup-matt-pocock-skills`

### What I typed

```
/setup-matt-pocock-skills with github issues, and others with default
```

Meaning: use GitHub for issues, take defaults for everything else.

### What Claude did

Scanned the current directory (empty), and because neither `CLAUDE.md` nor `AGENTS.md` existed, asked which one to create. I picked `CLAUDE.md`.

It then wrote 4 files:

```
CLAUDE.md                          ← Agent skills config entry point
docs/agents/issue-tracker.md       ← "Issues live on GitHub; use the gh CLI"
docs/agents/triage-labels.md       ← The 5 canonical triage roles
docs/agents/domain.md              ← How to read CONTEXT.md / ADRs
```

### Why this step matters

Every skill used later (grill, to-prd, to-issues) **reads these files** to learn:
- Should it `gh issue create`, write to `.scratch/`, or something else
- Which label to apply for "ready for AFK agent"
- Where to find project terminology

Skip this step and every later skill has to "ask the same thing again" or guess. Once done, Claude **never asked again** in the entire session about "where do I post this issue" or "which label do I use."

---

## Step 2: Create the GitHub repo

### What I typed

```
Create a GitHub repository and push it up.
```

### What Claude did

Asked me two things — repo visibility (Public) and repo name (matching the directory name, `agentic-ai-from-zero`) — and then:

```bash
git init -b main
git add CLAUDE.md docs/
git commit -m "Initial commit: set up agent skills config"
gh repo create agentic-ai-from-zero --public --source=. --remote=origin --push
```

Initial commit `a7ce8d8` pushed to https://github.com/sunfmin/agentic-ai-from-zero

### Small details from this step

I said "create the repo and push" without saying "git init first" — Claude saw there was no `.git` and added that step itself. It **confirmed the risky decision** (visibility public vs. private) before creating anything; it didn't just default to public and run.

---

## Step 3: Turn "I want to write a tutorial" into 14 concrete decisions — `/grill-with-docs`

### What I typed

```
/grill-with-docs I want to create a from-zero tutorial in this repo,
for users with no foundation, who have only used GUI tools and never used
the command line, teaching them how to use Claude Code and create skills.
```

### What `grill-with-docs` is

Its job is to **interrogate**: one question at a time, each with a recommended answer plus the reasoning, waiting for me to confirm/reject/adjust before moving on. Along the way it captures resolved domain terms into `CONTEXT.md`, and turns "hard-to-reverse + future-readers-will-wonder + real-trade-off" decisions into ADRs under `docs/adr/`.

### The 14 questions, in order

Here are the questions Claude asked, my answers, and where each decision landed:

| # | Question | My answer | Landed in |
|---|---|---|---|
| 1 | What OS does the target reader use? | macOS | Later became ADR-0001 |
| 2 | What's the tutorial's endpoint? (A: can chat / B: can write first skill / C: can write a "real" skill) | C, **and bilingual** | CONTEXT.md |
| 3 | What shape does "bilingual" take? (parallel-page / separate dirs / term annotations) | Per recommendation: separate `zh/` + `en/` dirs | CONTEXT.md |
| 4 | Delivery format? (pure markdown / static site / single long doc) | Per recommendation: pure markdown | — |
| 5 | Who is the reader? (designer / PM / pure curiosity / used GUI AI tools before) | **D, but examples should cover A and B** | CONTEXT.md |
| 6 | Where is the reader? (mainland China / overseas Chinese / undefined) | Per recommendation: overseas Chinese + mainland readers who already have VPN + foreign card | Later became ADR-0001 |
| 7 | Does this 11-chapter outline work? | Per recommendation | CONTEXT.md |
| 8 | What's the running project scenario? (personal writing / design brief / meeting notes) | Per recommendation: personal writing | CONTEXT.md |
| 9 | How should chapter 2 recommend payment? | Per recommendation: main path Pro + sidebar comparing Max/API | CONTEXT.md |
| 10 | How is the repo laid out? | Per recommendation: `tutorial/zh/` + `tutorial/en/` | CONTEXT.md |
| 11 | Hands-on intensity? (pure read / read-and-do / project-driven) | Per recommendation: read-and-do (🛠 Try-it boxes) | CONTEXT.md |
| 12 | Terminology translation policy? (translate all / keep all / layered) | Per recommendation: layered (commands in English, generic terms in Chinese, neologisms kept in English) | CONTEXT.md |
| 13 | Versioning policy? (no lock / pin a version / no lock + per-chapter timestamps) | Per recommendation: no lock + timestamps | Later became ADR-0002 |
| 14 | Build any ADRs? How many? | Per recommendation: build two (scope + versioning) | docs/adr/0001, 0002 |

### What Claude gave me for each question

Not just a dry "pick A/B/C." Every question came with:

- **Question background** (why this is a decision at all)
- **3–4 candidates** with their respective costs
- **An explicit recommendation** with reasoning (typically 4–5 bullets)
- **Reasons for rejecting other candidates** (to prevent me from picking without thinking)

Example, the recommendation portion of Question 1:

> **My recommendation: macOS only, for now.** Reasoning:
> 1. You (sunfmin) are on a Mac — you can write it and verify it live
> 2. For zero-base users, the path on Mac is shortest and least pothole-prone
> 3. The Windows branch needs WSL2 first, which inserts a whole asynchronous chapter ahead of the main thread
> 4. If Windows support is needed later, it can be a separate "Windows companion" volume

Every question, I could judge "yes/no" within 30 seconds, with almost no real-time thinking — because Claude had already laid out the candidates and tagged "why I wouldn't pick X."

### Side effects during the grill

Right after I answered Question 12 (terminology policy), Claude **on its own** created `CONTEXT.md` and landed everything already resolved — "reader archetype," "chapter outline," "running project," "terminology table," "payment path" — into it. This is the `grill-with-docs` rule "update CONTEXT.md inline as each term is resolved" in action.

After Question 14, it built two ADRs:

- `docs/adr/0001-tutorial-scope.md` — macOS only + assume reader has VPN/foreign card
- `docs/adr/0002-versioning-policy.md` — no version pin + per-chapter calibration timestamps

### Commit

When I said "commit and push," Claude packaged `CONTEXT.md` + the two ADRs into one commit (`904edf9`) and pushed it to GitHub.

### Why this step matters

The tutorial **hadn't been written yet — not a single word**, but nearly every disagreement that could cause rework later was already settled. Who the zero-base reader is. Which OS. How "bilingual" is implemented. Which terminology policy. How to handle versioning. Without the grill, these surface either as reader complaints after three chapters are written, or as recurring hesitation every time you open a new chapter.

More importantly: **decisions leave a paper trail**. `CONTEXT.md` is the terminology dictionary + reader archetype; ADRs are the rationale ledger for the hard-to-reverse decisions. Six months later, when I come back myself — or a collaborator joins the project for the first time — they can see "why was this tutorial designed this way."

---

## Step 4: Synthesize all the decisions into a PRD — `/to-prd`

### What I typed

```
/to-prd
```

Bare command, no extra explanation. The whole point of `to-prd` is **don't interview the user — just synthesize the existing context**.

### What Claude did

First, it **carved out the modules** and showed me the candidates:

- M1 Repo scaffold + chapter conventions (deep module)
- M2 Chinese chapter content
- M3 English mirror
- M4 Example skill artifacts (deep module)
- M5 Running-project starter

It explicitly tagged **which two are deep modules** (stable interface, independently testable), and recommended **writing automated verification only for M1 + M4** (the other modules can't be automated — "whether Homebrew installs cleanly on a fresh Mac" is something automation can't replicate for a real new reader).

I answered "per the recommendation," and Claude wrote the PRD and published it as GitHub issue #1, with label `ready-for-agent`:

https://github.com/sunfmin/agentic-ai-from-zero/issues/1

### What's in the PRD

Following the `to-prd` template (problem / solution / user stories / implementation decisions / testing decisions / out of scope / further notes):

- **26 user stories** covering reader, maintainer, and future-contributor perspectives
- **Responsibility boundaries for 5 modules**, with each module's interface called out
- **The 11-chapter outline** (frozen during the grill)
- **Cross-cutting conventions** (calibration header, 🛠 box shape, terminology table, naming rules)
- **Testing strategy** (M1 lint script + M4 skill verification script; nothing else auto-tested)
- **Out of scope** (Windows / mainland China network / hooks / MCP / video) — defining it negatively cuts down future bikeshedding

### Bonus: backfilled the 5 canonical triage labels

The earlier setup step only wrote the label **convention** into `docs/agents/triage-labels.md` — the actual labels didn't exist on the GitHub repo yet. When `to-prd` went to create the issue, it called `gh label list`, noticed 4 were missing (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`), and just created them, then posted the issue.

Small detail, but pivotal — Claude detected a **gap between protocol and reality** and closed it on its own, without making me `gh label create` four times by hand.

### Why this step matters

The PRD is not handwritten — and not "AI polished a draft I wrote." It is a **mechanical synthesis of all the decisions captured during the grill**. Put differently, **the real design work was already done in the grill**; `to-prd` just packages those decisions into a template an AFK agent can act on directly.

If you skip the grill and go straight to `/to-prd`, you get a PRD that "sounds reasonable but every line is generic" — because no decision was ever made concretely. That's a grill problem, not a `to-prd` problem.

---

## Step 5: Cut the PRD into 11 vertical slices — `/to-issues`

### What I typed

```
/to-issues
```

Another bare command. `to-issues` knows to read issue #1 on its own.

### What Claude did

Following the **tracer-bullet** principle (each slice cuts end-to-end through every layer, never horizontally across one layer), it proposed 11 slices:

| # | Slice | Type |
|---|---|---|
| #2 | Tracer: scaffold M1 + chapter 0 | **HITL** |
| #3 ~ #11 | One chapter per slice; companion skill artifacts and starter content embedded | AFK |
| #12 | Chapter 10 (next steps) | AFK (only depends on #2) |

Key judgments:

- **Slice #2 is HITL** because the other 10 slices all build on its conventions — you really want to read its PR carefully before merging
- **zh and en are not separate slices** — same chapter, done together (the PRD already says "Chinese first → calibrate → English mirror")
- **Dependencies are strictly linear** (except #12 Chapter 10, which doesn't depend on the chapter chain — only on the tracer)
- **M4 skill artifacts are embedded inside the ch6/7 slices** — the chapter and the skill it produces are two faces of the same thing; splitting them risks one side getting ahead while the other stalls

I answered "per the recommendation," and Claude posted 11 issues in dependency order (#2 through #12), each one referencing its blocker.

### What each issue looks like

The template (enforced by `to-issues`):

- **Parent**: #1 (the PRD)
- **What to build**: end-to-end behavior description, **no specific file paths** (they rot fast)
- **Acceptance criteria**: checkbox list, each line independently verifiable
- **Blocked by**: reference to the previous issue

Each issue is sized for "an AFK agent can finish it in a day or two."

### Why this step matters

A PRD is a "whole-system view" — an agent reading it doesn't know where to start chewing. Cut into 11 vertical slices, you get:

- Each slice has a clear entry (blocker) and exit (acceptance criteria)
- Agents can grab **independent** slices in parallel (#12 Chapter 10 can run alongside the main chain)
- HITL/AFK tags tell the agent which it can finish solo and which need a human in the loop
- "Vertical slice" guarantees that merging any slice leaves the repo in a **demoable incremental state**, not half-finished

---

## Total session output

### Repo files (already pushed to GitHub)

```
CLAUDE.md                              ← Agent protocol entry point
CONTEXT.md                             ← Bilingual glossary + reader archetype
docs/
├── adr/
│   ├── 0001-tutorial-scope.md         ← macOS only + overseas readers
│   └── 0002-versioning-policy.md      ← No version pin + per-chapter timestamps
└── agents/
    ├── issue-tracker.md               ← GitHub + gh CLI
    ├── triage-labels.md               ← 5 canonical roles
    └── domain.md                      ← CONTEXT.md / ADR consumer rules
```

### GitHub state

- 1 public repo: https://github.com/sunfmin/agentic-ai-from-zero
- 2 commits: `a7ce8d8` (initial setup), `904edf9` (lock scope and terminology)
- 1 PRD (issue #1) + 11 slice issues (#2 ~ #12)
- 5 triage labels (needs-triage / needs-info / ready-for-agent / ready-for-human / wontfix)

### Decision paper trail

- All 14 specific design decisions are backed by `CONTEXT.md` or one of the two ADRs
- Zero "I was thinking this at the time but didn't write it down" black boxes

---

## Why you should follow this flow (the benefits)

### 1. I never wrote prose, yet decisions landed at "an AFK agent can pick this up and start" granularity

Across the entire session I typed maybe 200 characters (most of my replies were "per the recommendation"). What came out the other end is a spec another agent — one who wasn't there — can take and open 11 PRs against.

### 2. Decisions aren't snap calls; they're "what do you plan to do about X" answers pulled out by Claude

The grill forces you to make a choice at every fork. I couldn't skip "should mainland readers be supported" and let it silently bite me later, because Claude asked.

### 3. The paper trail is a free byproduct, not extra work

`CONTEXT.md` and the ADRs aren't "documentation written after the fact to capture decisions" — they were written **right there during the grill**. I didn't spend an afternoon "tidying decisions into ADRs."

### 4. PRDs and issues are mechanical outputs, not creative outputs

`/to-prd` and `/to-issues` don't do fresh design work — they just stuff already-resolved decisions into the PRD and issue templates. That's why those steps are fast and hard to get wrong. If the grill was shallow, the PRD comes out generic — but that's a grill problem, not a `to-prd` problem.

### 5. The protocol (CLAUDE.md + docs/agents/) is the wiring harness for every other skill

Every subsequent skill quietly reads `docs/agents/issue-tracker.md` and `docs/agents/triage-labels.md`. I never had to say "use GitHub for issues, this is the label vocabulary" a second time. That's the leverage from doing setup.

---

## How to reuse this flow

### Opener

1. Install Claude Code + Matt Pocock's skills (see the README at `mattpocock/skills`)
2. `cd` into your project directory (which can be empty)
3. `claude`

### Recommended sequence

```
/setup-matt-pocock-skills              ← Wire up the protocol
(create the GitHub repo + push)        ← Give agents a place to post issues
/grill-with-docs <one-line of what you want to build>
                                       ← Turn a fuzzy idea into concrete decisions
/to-prd                                ← Synthesize decisions into a PRD
/to-issues                             ← Cut the PRD into executable issues
```

### Key 1: be willing to be interrogated by the grill

The value of the grill is that it **makes you answer questions you wouldn't have thought to ask yourself**. Answering "per the recommendation" every time is fine (it means Claude's defaults were reasonable), but the higher-value moments are when you answer "no, I want X instead of Y" — those are the parts Claude can't decide for you.

### Key 2: don't skip setup

If you don't write `docs/agents/*`, every later skill has to re-ask "where do I post this issue" and "what's the label." That's a 5-minute one-time investment that saves 20 repeat conversations.

### Key 3: treat the paper trail as the default

`CONTEXT.md` and the ADRs are the things **your future self** will thank you for the most. Six months from now when you come back, or someone joins, or you want to hand the work to an AI agent — they all use those documents to "get up to speed fast."

---

## A mental model for "managing a project with Claude Code"

```
Fuzzy idea
   │
   │ /setup-matt-pocock-skills  ← Once. Wire the protocol.
   │
   ▼
Empty repo with a protocol
   │
   │ /grill-with-docs           ← Squeeze idea into decisions
   │  → CONTEXT.md, ADR/
   │
   ▼
Repo with a paper trail of decisions
   │
   │ /to-prd                    ← Synthesize into PRD
   │  → issue #N (the PRD)
   │
   ▼
Repo with a PRD
   │
   │ /to-issues                 ← Cut into vertical slices
   │  → issues #N+1...
   │
   ▼
A pile of ready-for-agent issues
   │
   │ AFK agents work
   │
   ▼
PRs, merges, calibration, next round
```

Every step **shrinks degrees of freedom**: fuzzy idea → decisions → PRD → issues. Every step has a visible output. Every step is committed and traceable.

---

## What's next for this repo

In issue order:

1. The tracer slice (#2) brings the M1 conventions to life — **HITL**, needs a human PR review
2. Slices #3 ~ #11 chain serially, executed by AFK agents
3. Slice #12 (Chapter 10 next-steps) can run in parallel with the main chain

The PRD in issue #1 is the "constitution" for every future change in this repo. New requirements either get their own PRD-prefixed issue via `/to-prd`, or get attached as sub-tasks under issue #1 via `/to-issues`.

---

One last note: **this document itself is part of the session**. I asked Claude to "write the entire process from start to finish into one document" — and it wrote what you just read. So this case study isn't just a case study; it's also evidence that the output quality of this flow is high enough to be demoed directly.
