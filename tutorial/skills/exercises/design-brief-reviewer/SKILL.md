---
name: design-brief-reviewer
description: |
  Reviews design briefs (markdown files describing a design project's
  goals, audience, constraints, and deliverables) for completeness and
  clarity. Checks whether the brief names: the audience, the success
  metric, the constraints (time / budget / technical), and the
  deliverables. Trigger when the user asks to "review", "audit",
  "critique", or "sanity-check" a design brief, or shares a markdown
  file labeled brief/design-brief and asks what's missing.
---

# Design Brief Reviewer

When the user asks for a design brief review:

1. Read the file they point at.
2. Check it against the four required sections:
   - **Audience** — who is this design for?
   - **Success metric** — how will we know it worked?
   - **Constraints** — what's the budget / timeline / tech stack / brand limits?
   - **Deliverables** — what hand-off artifacts come out at the end?
3. For each section: mark "present", "vague", or "missing". For vague sections, quote the relevant line and explain what's missing. For missing sections, suggest a one-line prompt to fill the gap.
4. End with a one-line overall: "this brief is ready / needs a revision pass / is not ready to start design work."

Be direct. The point of a brief review is to catch ambiguity before design effort goes into the wrong place.
