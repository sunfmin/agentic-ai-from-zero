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
| 10-next-steps | 2026-05        | v2.x                | n/a (no commands) | Curated outbound links only |
