# sample-project — a tiny codebase to practice on

This is a throwaway sample codebase used by **chapter 15** of the tutorial. It is
intentionally *imperfect*: a small order-intake flow with a real architecture
smell baked in, so that `/improve-codebase-architecture` has something genuine to
find when you run it.

Do **not** treat this as exemplary code. It exists to be critiqued.

## What it pretends to do

Take an incoming order, check it's valid, work out what it costs, save it, and
tell the customer. About 150 lines of TypeScript across a handful of files.

```
src/
├── types.ts            shared shapes
├── placeOrder.ts       the entry point — orchestrates the flow
├── validateOrder.ts
├── calculatePricing.ts
├── orderRepository.ts
└── notifyCustomer.ts
```

## How chapter 15 uses it

You don't run this project — there's no build step and nothing to execute.
`/improve-codebase-architecture` only *reads* the code and produces a report.
So all you need is the source above.

If you have a real codebase of your own, point the skill at that instead — it's
far more interesting to see the skill describe code you wrote. This sample is
here so the chapter works even if you don't.
