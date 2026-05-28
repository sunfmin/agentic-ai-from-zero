---
name: meeting-action-extractor
description: |
  Extracts action items from raw meeting notes. Each action item is
  attributed to a person (or "unassigned") and given a due date if one
  was mentioned. Trigger when the user asks to "extract actions",
  "pull action items", "what did we agree to do", "list todos from this
  meeting", or shares meeting notes and asks who owns what next.
---

# Meeting Action Extractor

When the user asks for action items from meeting notes:

1. Read the notes the user provided.
2. Scan for explicit and implicit commitments:
   - Explicit: "Sarah will do X by Friday."
   - Implicit: "We need to figure out X" with a name attached or context implying ownership.
3. Output a numbered list, one action per line, in this exact shape:

   > **N.** [Owner] — [verb-led action] — [due date or "no date"]

4. After the list, give a one-line note flagging any item where the owner was ambiguous or the date was unclear.

Be strict: do not invent owners. If the notes don't name a person, the owner is "unassigned" — surface that as a flag so the human can resolve it.
