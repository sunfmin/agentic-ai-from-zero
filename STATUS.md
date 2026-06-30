# STATUS

Maintainer dashboard. One row per chapter file. Update this row in the same commit as any calibration bump.

`scripts/lint-chapters.sh` requires every chapter file in `tutorial/zh/` and `tutorial/en/` to have a row here.

| Chapter slug | Last calibrated | Claude Code version | Verified on Mac? | Notes |
|--------------|-----------------|---------------------|------------------|-------|
| 00-preface   | 2026-05         | v2.x                | n/a (no commands) | Initial draft |
| 01-terminal  | 2026-05         | v2.x                | yes               | Five commands (pwd, ls, cd, mkdir, open) |
| 02-toolbox   | 2026-05         | v2.x                | yes               | Homebrew → Node.js → Claude Code → login; payment sidebar |
| 03-first-session | 2026-05     | v2.x                | yes               | Three interactions: read, write, run; names session/working-dir/permissions |
| 04-running-project | 2026-05   | v2.x                | yes               | Personal-writing folder; CLAUDE.md written collaboratively; ships M5 starter |
| 05-whats-a-skill | 2026-05     | v2.x                | n/a (conceptual)  | Three ideas: skill≠prompt, minimal shape, trigger mechanism |
| 06-first-skill | 2026-05       | v2.x                | partial (structure verified; live trigger pending) | Ships M4 v1 artifact + verify script |
| 07-multi-file-skills | 2026-05 | v2.x                | partial (structure verified; live trigger pending) | Ships M4 v2 artifact (SKILL.md + principles.md) |
| 08-skill-creator | 2026-05     | v2.x                | n/a (concept + checklist) | /skill-creator walkthrough + before/after description tuning + debug checklist |
| 09-exercises | 2026-05         | v2.x                | partial (reference skills structure-verified) | Three exercises + reference SKILL.md answers under tutorial/skills/exercises/ |
| 10-version-and-share | 2026-05 | v2.x                | partial (concepts verified; gh auth/push pending) | git/GitHub via Claude; commit/diff/revert + publish + clone-to-install |
| 11-setup-skills | 2026-06     | v2.x                | partial (authored; not yet run on a clean Mac) | Part 2 opener: 4-failure-modes framing + npx skills install + /setup-matt-pocock-skills |
| 12-grill-with-docs | 2026-06  | v2.x                | partial (authored; not yet run on a clean Mac) | grill-with-docs = /grilling + /domain-modeling; CONTEXT.md + ADR grow inline |
| 13-to-prd | 2026-06          | v2.x                | partial (authored; not yet run on a clean Mac) | /to-prd: no interview, seam sketch, 7-section template, ready-for-agent issue |
| 14-to-issues | 2026-06       | v2.x                | partial (authored; not yet run on a clean Mac) | /to-issues: vertical (tracer-bullet) slices, quiz, dependency-ordered publish |
| 15-improve-architecture | 2026-06 | v2.x            | partial (authored; runs against tutorial/sample-project/) | /improve-codebase-architecture: deep/shallow vocab, HTML report, grilling loop |
| 16-next-steps | 2026-05        | v2.x                | n/a (no commands) | Curated outbound links only; renumbered from 11 |
