---
name: prd-note-drafter
description: |
  Drafts a structured PRD note from any kind of rough input — meeting
  notes, Slack quotes, bullet lists, mixed messy text. Output sections:
  Problem, Proposed solution, Open questions, Decided next steps, Risks.
  Trigger when the user asks to "turn this into a PRD", "draft a PRD",
  "make a PRD note", "extract a PRD from this", "write up these notes
  as a PRD", or any close variation. Also trigger if the user pastes
  rough meeting content and asks for a structured writeup.
---

# PRD Note Drafter

When the user asks to turn rough input into a PRD note:

1. Read what the user provided — pasted text, a file path, or a referenced earlier message.
2. Extract content into five sections, in this order:
   - **Problem** — what is broken / unclear / contested?
   - **Proposed solution** — what is being suggested? Multiple options if more than one came up.
   - **Open questions** — what's not yet decided?
   - **Decided next steps** — what was actually agreed?
   - **Risks** — anything called out as concerning, blocking, or fragile.
3. Quote source phrasing only when the rough text was concrete; otherwise rephrase tightly.
4. If a section has nothing to populate from the input, write "(not in input)" rather than inventing.

Keep section headers in this exact form so downstream skills / tools can parse them.
