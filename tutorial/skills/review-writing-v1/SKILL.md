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

When the user asks for a writing review on a draft, do the following:

1. Read the file the user points at. If they don't name a file, ask which one.
2. Check the prose against the four **principles** below. For each issue you find, quote the original sentence and propose a tighter rewrite.
3. End the review with a one-line overall assessment that names which of the four principles the draft struggles with most.

## Principles

**P1 — One idea per sentence.** Sentences that string together two or more independent claims with "and", ", which", or semicolons usually hide a structural problem. Split them. If a sentence has more than ~30 words, suspect P1 violation.

**P2 — Active voice.** "X was done by Y" almost always reads worse than "Y did X." Look for `was/were/been/being + past participle` constructions and rewrite as active.

**P3 — Concrete verbs over abstract nouns.** "We made an improvement to" → "We improved." "The deployment of the tool was completed" → "We deployed the tool." Nominalizations (verbs turned into nouns: improvement, deployment, completion, identification, optimization) signal P3 violations.

**P4 — Cut filler and corporate-speak.** Phrases that sound important but mean nothing: "going forward", "at the end of the day", "leverage", "synergy", "drive value", "in order to", "for the purpose of", "as part of our broader X journey". Delete them; the sentence usually still works.

## Output format

For each issue, use this shape:

> **[Principle code]** Original: "..."
> Rewrite: "..."

Then at the bottom:

> **Overall:** This draft struggles most with [principle code]. [One-sentence summary.]

Be specific and direct. Don't soften with "consider" or "you might want to". The user asked for a review; give one.
