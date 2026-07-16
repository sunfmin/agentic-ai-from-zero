# Chapter 12 — Grill a Fuzzy Idea into Decisions

_Last calibrated: 2026-06, against Claude Code v2.x_

Last chapter you built a repo with a protocol and a one-line idea in your head (this book's example: "a reading-list app"). This chapter **squeezes that sentence into a string of concrete decisions** — and the decisions get written down as they're made. The skill is `/grill-with-docs`.

It's the author's most popular skill, and maybe the most valuable one in the set. But what it does fits in a sentence: **grill you, then write down the answers.**

## `/grill-with-docs` = grilling + recording

This skill is two smaller skills bolted together:

- **`/grilling`** — like an interviewer, it asks **one question at a time**, walking down the "decision tree" branch by branch, and gives you a **recommended answer** for each. Asking many at once is bewildering, so it asks one, waits for your reply, then asks the next. Anything it can answer by reading the code, it reads instead of asking you.
- **`/domain-modeling`** — while grilling, it **builds a glossary as it goes**: challenging words you used wrong, sharpening fuzzy words into precise ones, stress-testing your concepts with concrete scenarios; the moment a word is pinned down, it writes it into `CONTEXT.md`; when a decision is hard to reverse, it records an ADR.

Together: you're forced to think the idea through, and the "thought-through product" lands as documentation automatically. **The paper trail is a free byproduct, not homework you do afterward.**

> 💡 The suite also has `/grill-me`, which only grills and builds no docs — good for non-code things (like thinking through an article's structure). `/grill-with-docs` is `/grill-me` plus the layer that builds `CONTEXT.md` and ADRs. For project work, use the one with docs.

## What grilling looks like

The point isn't that "it asks questions" — it's that **for each question it's done most of the homework for you**. It won't just toss you "do you want A or B?" Each question usually gives you:

- **Background** — why this is even a decision;
- **Three or four candidates** — and what each costs;
- **One clear recommendation** — plus a few reasons for it;
- **Why not the others** — so you don't pick before thinking.

So most of the time you can judge "yes / no" in half a minute without thinking hard on the spot. The valuable moments are the ones where you answer "**no, I want X, not Y**" — that's the part Claude can't do for you.

The [`BOOTSTRAP-CASE-STUDY.en.md`](../../BOOTSTRAP-CASE-STUDY.en.md) at the repo root walks through one real session: the author used this skill to grill "I want to make a tutorial" into **14 concrete decisions** (which OS? is the destination "writes a skill" or "can converse"? how does bilingual work? who's the reader?...). To see what real Q&A looks like, read it — the tutorial it produced is the one you're reading now.

## Hands-on: grill your idea

Back in the practice repo from last chapter (the example's `~/reading-list`), open Claude. Send your one-line idea after `/grill-with-docs`.

> 🛠 Try it
>
> In the prompt, type (swap in your own idea):
>
> > `/grill-with-docs I want a small app to track the books and articles I want to read — add items, tag them, mark them done, and see how many are left.`
>
> You should see: Claude **not** start writing anything immediately. It throws out the **first** question — usually the most foundational one, the one that shapes everything after it (e.g. "Is this list just for you, or for collaborators? That decides whether you need accounts"), with its recommendation and reasoning. Then it stops and waits for you.

From there you walk the decision tree together. For each question you can:

- find the recommendation reasonable → answer "go with the recommendation" or "agreed";
- have your own view → answer "no, I want X," with a one-line why;
- want to ask it something back → just ask; it answers, then returns to the thread.

> 🛠 Try it
>
> Answer your way down until it's done (a small project is usually five to a dozen-ish questions). Watch for two kinds of moment along the way:
>
> - It **challenges a word**: e.g. you say "article" one moment and "item" the next, and it asks "are those the same thing? Which do we call it?" — that's domain-modeling tightening terminology.
> - It **reads rather than asks**: if a question can be answered by glancing at the code, it reads the code instead of asking you. (This empty repo has no code yet, so you mostly won't see it here; chapter 15, against a repo with code, makes it obvious.)

## Watch the "byproducts" grow in real time

Mid-grill, without you prompting, Claude **builds files on its own**. This is the most valuable part of the skill.

> 🛠 Try it
>
> Once a few terms have been pinned down, open another terminal window (or ask Claude to list it) and look:
>
> Type: `cat CONTEXT.md`
>
> You should see: a glossary taking shape — the words you and Claude just agreed on (what "item," "tag," "done" mean, and how they relate), written down one by one. It holds **only terminology**, no implementation detail, and isn't used as a scratch pad.

ADRs, by contrast, are created **sparingly**. Claude only proposes an ADR when a decision satisfies **all three**:

1. **Hard to reverse** — changing your mind later costs real effort;
2. **Confusing without context** — a future reader will ask "why did they do it this way?";
3. **The result of a genuine trade-off** — there were real alternatives and you picked one for specific reasons.

Miss any one and it skips the ADR. So you won't be drowned in ADRs over trivia.

> 🛠 Try it
>
> If such a decision actually came up while grilling (e.g. "are done items soft-deleted or really deleted"), Claude asks **whether** to record it as an ADR. Say yes, then look:
>
> Type: `ls docs/adr/`
>
> You should see: an `NNNN-title.md` file spelling out the decision, the options at the time, and why the current one was chosen. Six months later, even you will understand it.

## Grill done = decisions finalized

When the grilling is over, you have more than "we talked it through" — you have:

- a repo with not a single line of business code yet;
- but every **dispute that could cause later rework** (accounts? multi-device sync? delete semantics?) already answered;
- and the answers are **on the record** — `CONTEXT.md` is the glossary, `docs/adr/` is the rationale book for hard-to-reverse decisions.

This step turns "fuzzy idea" into "finalized decisions." **The real design work is done in this chapter.** Next chapter's `/to-spec` does no new design — it just packs these decisions into a template. So the harder you grill, the easier everything after; grill lazily, and the PRD comes out vague and empty.

Save this step's output:

> 🛠 Try it
>
> Tell Claude: `Commit CONTEXT.md and everything under docs/ and push.`
>
> You should see: Claude commit `CONTEXT.md` and those ADRs together and push them to GitHub.

## Recap

- `/grill-with-docs` = `/grilling` (grill) + `/domain-modeling` (build the glossary and ADRs).
- Grilling asks **one question at a time**, each with background, candidates, a recommendation, and "why not the others."
- The valuable parts are the moments you answer "no, I want X" — and the `CONTEXT.md` and ADRs that **grow in real time**.
- ADRs are created sparingly: **hard to reverse + confusing without context + a genuine trade-off**, all three, or it skips.
- The real design happens here; the later PRD and issues are mechanical synthesis. The depth of the grilling sets the ceiling on everything after.

## Next

[Chapter 13 — *Synthesize Decisions into a PRD*](./13-to-spec.md). You'll fire a bare `/to-spec` and watch it **ask you nothing**, synthesizing this chapter's decisions straight into a full PRD and filing it as a GitHub issue.
