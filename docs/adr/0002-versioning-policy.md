# Versioning policy: don't pin Claude Code; track per-chapter calibration dates

Claude Code ships new versions on a weekly–biweekly cadence. The tutorial deliberately **does not pin to a specific Claude Code version**. Instead, every chapter carries a small header line of the form:

> _Last calibrated: 2026-05, against Claude Code v2.x_

A root-level `STATUS.md` aggregates these so a maintainer can see at a glance which chapters are stalest.

## Why considered, why rejected

- **Pinning to a version**: looks rigorous, but a reader landing a year later cannot install the old version. They would follow commands that no longer work and conclude "the tutorial is broken." Pinning shifts blame to the tutorial without giving the reader a way out.
- **No timestamps at all**: works for the first writing pass, but a reader two years later has no way to tell whether a discrepancy is their mistake or a Claude Code change. The maintainer also has no signal to know which chapters need re-verification.

Per-chapter timestamps put the maintenance signal exactly where it's needed (top of each chapter the reader is currently reading) and let chapter-by-chapter re-calibration happen asynchronously — no need to re-verify the whole book for every Claude Code release.

## Consequences

- Every chapter file starts with the calibration line, even if it's "_Last calibrated: never_" at first.
- `STATUS.md` is a maintainer-facing dashboard. It is *not* linked from the reader-facing entry points.
- When a chapter is re-calibrated, the maintainer bumps both the chapter header and the matching row in `STATUS.md` in the same commit.
