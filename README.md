# Agentic AI from Zero

> 🌐 **中文版**：[`README.zh.md`](./README.zh.md)

A bilingual (Chinese + English) tutorial repository that takes a complete CLI beginner from "I've never opened the terminal" to "I've written a multi-file Claude Code skill."

This repository contains:

- **The tutorial itself** — under [`tutorial/`](./tutorial/README.md), with mirrored `zh/` and `en/` directories
- **Example skill artifacts** *(coming with later slices)* — installable artifacts the tutorial references
- **Decision documents** — [`CONTEXT.md`](./CONTEXT.md) (glossary + reader archetype) and [`docs/adr/`](./docs/adr/) (architecture decisions)
- **Bootstrap case study** — how this very repository was assembled in a single Claude Code session: [`BOOTSTRAP-CASE-STUDY.md`](./BOOTSTRAP-CASE-STUDY.md) (中文) and [`BOOTSTRAP-CASE-STUDY.en.md`](./BOOTSTRAP-CASE-STUDY.en.md) (English)

## Scope at a glance

- **macOS only** — see [ADR-0001](./docs/adr/0001-tutorial-scope.md)
- **Bilingual** (Chinese + English) in mirrored directories
- **Versioning posture**: no global Claude Code pin; per-chapter calibration timestamps. See [ADR-0002](./docs/adr/0002-versioning-policy.md) and [`STATUS.md`](./STATUS.md).

## Start reading

→ [`tutorial/README.md`](./tutorial/README.md) — language picker

## For maintainers

- [`STATUS.md`](./STATUS.md) — per-chapter calibration dashboard
- [`scripts/lint-chapters.sh`](./scripts/lint-chapters.sh) — run before committing any chapter change
- [`CONTEXT.md`](./CONTEXT.md) — terminology table (what gets translated and what stays English)
- [`docs/`](./docs/) — ADRs and agent configuration
