---
name: review-writing
description: |
  Reviews drafts (markdown files containing prose, blog posts, announcements,
  meeting summaries, launch notes, internal communications) for four common
  writing problems: wordiness, passive voice, abstract nouns where concrete
  verbs would work, and filler / corporate-speak. Trigger when the user asks
  to "review", "edit", "critique", "improve", "tighten", or "give feedback on"
  a draft or any prose, or when they share a markdown file and ask what's
  wrong with it.
---

# Review Writing

When the user asks for a writing review on a draft:

1. Read the file the user points at. If they don't name a file, ask which one.
2. Read [principles.md](./principles.md) for the four principles (P1..P4) and how to spot each one.
3. Check the draft against the principles. For each issue, quote the original sentence and propose a tighter rewrite, tagged with the principle code.
4. End the review with a one-line overall assessment that names which principle the draft struggles with most.

## Output format

For each issue, use this shape:

> **[Principle code]** Original: "..."
> Rewrite: "..."

Then at the bottom:

> **Overall:** This draft struggles most with [principle code]. [One-sentence summary.]

Be specific and direct. Don't soften with "consider" or "you might want to". The user asked for a review; give one.
