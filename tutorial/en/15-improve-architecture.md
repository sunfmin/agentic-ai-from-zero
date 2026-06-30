# Chapter 15 — Deepen a Codebase

_Last calibrated: 2026-06, against Claude Code v2.x_

The first four chapters plan **new features**. This chapter switches entry points: it runs against **existing code**, finding architectural problems and fixing them. The skill is `/improve-codebase-architecture`.

What it hunts for has a name: **deepening opportunities** — turning a "shallow module" into a "deep" one. AI writes code fast, and just as fast it piles a codebase into a **ball of mud**. The author recommends running this skill on your own codebase every few days to keep the entropy down.

## First, a few words: deep vs shallow modules

This skill speaks in a precise vocabulary throughout. Get the core two straight first.

- **module** — anything with an interface and an implementation: a function, a class, a package, all count.
- **interface** — **everything you must know** to use the module correctly: not just the function signature, but its preconditions, ordering requirements, error modes, performance characteristics.
- **deep / shallow** — a module is **deep** when "**a lot of behavior sits behind a small interface**": you learn a little (the small interface) and get a lot (the big implementation). A module is **shallow** when "the interface is nearly as complex as the implementation" — what you must learn to use it is about as much as it does. **Shallow modules are what to avoid.**

```
deep module (want)          shallow module (avoid)
┌──────────────┐          ┌────────────────────────┐
│ small iface  │          │      large iface       │
├──────────────┤          ├────────────────────────┤
│              │          │  thin impl (mostly just │
│ big impl     │          │  forwarding)            │
│ (hides the   │          └────────────────────────┘
│  complexity) │
└──────────────┘
```

To judge whether a module is just taking up space, use the **deletion test**: imagine deleting it. If the complexity **vanishes**, it was a forwarding shell (shallow); if the complexity **scatters across a pile of callers**, it was earning its keep (deep).

Two more words that recur in the report:

- **leverage** — what callers get: learn a little interface, get a lot of capability. One implementation pays back across N call sites.
- **locality** — what maintainers get: changes, bugs, and knowledge **concentrate in one place** rather than scattering across callers. Fix once, fixed everywhere.

> 💡 Two more terms will show up. **seam**: a place where you can swap a module's behavior without editing it in place (where tests hook in — you saw it last chapter). **adapter**: the concrete thing that satisfies an interface at a seam. A rule of thumb: "**one adapter is only a hypothetical seam; two adapters make it a real one**" — if nothing actually varies there, don't force a seam open.

## Hands-on: find a codebase to run against

> 🛠 Try it
>
> **First choice**: if you've started writing some reading-list code, or have any small codebase handy — use it; watching the skill describe code **you** wrote is the most satisfying way to learn it.
>
> **If you don't**: this book ships a tiny sample codebase at `tutorial/sample-project/` (a deliberately slightly-tangled "place an order" flow). Clone this book's repo locally and `cd` into that folder:
>
> > ```
> > cd path/to/this-tutorial/tutorial/sample-project
> > claude
> > ```
>
> You should see: Claude Code starting in that little project.

> 💡 This skill only **reads** code and produces a report — it **runs** nothing. So the sample project need not be runnable; you don't install dependencies.

Run it:

> 🛠 Try it
>
> In the prompt, type: `/improve-codebase-architecture`
>
> You should see: Claude first read `CONTEXT.md` and ADRs for vocabulary (if any exist), then walk the code with an explore agent, looking for **where it feels off** — which module is shallow, where logic leaks across a seam, where it's awkward to test. (In the sample project, it'll likely zero in on things like "pricing logic spread across three places" and "the validation layer is nearly an empty shell.")

## The report: a self-contained HTML page

Once it's done walking, it does **not** dump a wall of text in the terminal. It writes a **self-contained HTML file** to the OS temp directory (nothing lands in your repo), opens it in your browser automatically, and tells you the absolute path.

> 🛠 Try it
>
> Wait for it to finish.
>
> You should see: your browser pop open a tastefully laid-out report page (styled with Tailwind, with relationship diagrams drawn by Mermaid). The terminal gives you something like "the report is at `/var/folders/.../architecture-review-<timestamp>.html`".

In the report, each **candidate** is a card:

- **Files** — which files/modules are involved;
- **Problem** — what's off about the current architecture (one sentence);
- **Solution** — what it'd change to (one sentence);
- **Before / After diagram** — side by side, drawing "how shallow it is now" and "how deep after deepening";
- **Wins** — the gains stated in terms of leverage / locality (e.g. "pricing stops leaking across the seam," "tests hit one interface");
- **Recommendation strength** badge — `Strong` / `Worth exploring` / `Speculative`.

It ends with a **Top recommendation** section telling you "if you act, act on this one first, and why."

> 💡 If a candidate conflicts with one of your ADRs, the report won't quietly override it — it flags it explicitly ("this conflicts with ADR-0003 — but worth reopening because…"), leaving the call to you.

After you read the report, it asks you: **"Which of these would you like to explore?"** — note that at this point it has **not yet** proposed any specific interface design. Pick one.

## Once you pick: another round of grilling

Once you pick a candidate, `/improve-codebase-architecture` drops back into the `/grilling` mode you know (chapter 12) and walks the deepening's design with you: what the constraints are, what the dependencies are, what shape the deepened module takes, what sits behind the seam, which existing tests survive.

> 🛠 Try it
>
> Pick the "Top recommendation," and follow it through a few rounds of Q&A.
>
> You should see: the same grilling as chapter 12 — one question at a time, each with a recommendation. And domain-modeling's side effects show up again:
>
> - if the deepened module needs a name **not yet in** `CONTEXT.md`, it **adds** the word to `CONTEXT.md`;
> - if a fuzzy word gets clarified mid-conversation, it updates `CONTEXT.md` on the spot;
> - if you **reject** the candidate for a "load-bearing" reason (one a future person would need to know to avoid re-suggesting the same thing), it asks whether to record an ADR, so the next architecture review doesn't dredge it back up.

When the grilling's done, you have a **thought-through deepening plan** — actually changing the code can go to a skill like `/tdd` (chapter 16 gives you the door) or you can do it by hand. This skill's job ends at "make the plan clear."

## Recap

- `/improve-codebase-architecture` is a separate entry point for **existing code**: find **shallow modules** and **deepen** them into deep ones.
- Core vocabulary: deep/shallow module, interface, seam, adapter, **leverage** (the caller's payoff), **locality** (the maintainer's payoff), the **deletion test**.
- The output is a **self-contained HTML report** (written to OS temp, never the repo), each candidate with a before/after diagram and a recommendation-strength badge.
- After you pick a candidate, it drops back into `/grilling` to walk the design; along the way it updates `CONTEXT.md` and proposes ADRs as needed.
- It only **clarifies** the deepening plan; actually changing the code is the next step.

## Next

[Chapter 16 — *Where to Go Next*](./16-next-steps.md). Part 2 ends here. The final chapter is the whole book's off-ramp: it tells you what's still **untaught** in this suite (`/tdd`, `/triage`, `/diagnosing-bugs`, and more), and what's behind the bigger doors — hooks, MCP, subagents.
