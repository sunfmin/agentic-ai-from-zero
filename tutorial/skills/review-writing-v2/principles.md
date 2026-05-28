# Writing-review principles

Four principles, in order of frequency of violation. The skill SKILL.md reads this file when a review is requested.

## P1 — One idea per sentence

Sentences that string together two or more independent claims with "and", ", which", or semicolons usually hide a structural problem. Split them. If a sentence has more than ~30 words, suspect P1 violation.

**Examples**

- Original: "We launched the product yesterday and feedback has been positive, although some issues were found which engineering is now investigating."
- Rewrite: "We launched the product yesterday. Feedback has been positive. Engineering is investigating a handful of issues."

## P2 — Active voice

"X was done by Y" almost always reads worse than "Y did X." Look for `was/were/been/being + past participle` constructions and rewrite as active.

**Examples**

- Original: "A retrospective will be conducted by the team next week."
- Rewrite: "The team will run a retrospective next week."

- Original: "Three additional services were migrated."
- Rewrite: "We migrated three more services."

## P3 — Concrete verbs over abstract nouns

Nominalizations (verbs turned into nouns: improvement, deployment, completion, identification, optimization, evaluation) signal P3 violations. Find the buried verb; promote it.

**Examples**

- Original: "We made an improvement to the planning cadence."
- Rewrite: "We improved the planning cadence."

- Original: "The deployment of the tool was completed last week."
- Rewrite: "We deployed the tool last week."

## P4 — Cut filler and corporate-speak

Phrases that sound important but mean nothing. Delete them; the sentence usually still works.

**Common filler to delete**

- "going forward"
- "at the end of the day"
- "leverage" (as a verb)
- "synergy"
- "drive value"
- "in order to" → just "to"
- "for the purpose of" → just "to" or "for"
- "as part of our broader X journey"
- "operational excellence" (without specifics)

**Examples**

- Original: "In order to enable us to better serve our stakeholders going forward, we will be implementing a number of important changes as part of our broader transformation journey."
- Rewrite: "We will make several changes to serve stakeholders better."
