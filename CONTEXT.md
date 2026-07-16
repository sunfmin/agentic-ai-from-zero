# Agentic AI from Zero — Tutorial Context

This repo hosts a bilingual (Chinese / English) tutorial that takes a reader from "never used the command line" to "can write a multi-file Claude Code skill" (Part 1, chapters 0–10), and then onward to "can drive a real project's planning and architecture with a professional skill suite" (Part 2 / 进阶篇, chapters 11–15; see [ADR-0005](./docs/adr/0005-engineering-skills-part.md)), and finally to "can run that plan as a fleet of parallel, unattended agents" (Part 3 / 执行篇, chapter 16; see [ADR-0007](./docs/adr/0007-orca-afk-fleet-execution-part.md)). This glossary defines the vocabulary the tutorial uses, so prose and code stay consistent across both languages and all chapters.

## Language

### Reader & audience

**reader / 读者**:
The target audience archetype: a person who has used GUI AI tools (ChatGPT web, Claude.ai) but never used the command line, on macOS, with access to international payment and to anthropic.com.
_Avoid_: user, audience, learner (unless explicitly meant in a different sense)

**D-type reader**:
Specifically: an ex-GUI-AI user being upgraded to CLI. The tutorial's main narrative ("from the chat box to the command line") is written for this archetype. Designers (A) and PMs (B) are example contexts the tutorial covers, not separate archetypes.

### Tutorial structure

**chapter / 章**:
One of the 18 numbered units (0 through 17): Part 1 is 0–10, Part 2 / 进阶篇 is 11–15, Part 3 / 执行篇 is 16, and the off-ramp (next-steps) is 17. Each chapter is one markdown file under `tutorial/zh/` and a mirror file under `tutorial/en/`. File names are `NN-slug.md` where `NN` is a two-digit number and `slug` is a short English identifier (same slug in both languages).
_Avoid_: lesson, section (section means something narrower — a heading within a chapter)

**进阶篇 / Part 2**:
Chapters 11–15, an explicitly-marked second part that teaches *using* five skills from the `mattpocock/skills` engineering suite as a project-management workflow. It expands the book's destination past Part 1's "write a multi-file skill" ceiling (see [ADR-0005](./docs/adr/0005-engineering-skills-part.md)). The reader does not learn to *build* these skills, only to use them as `/commands`.
_Avoid_: appendix (it is taught material, not reference), 番外

**执行篇 / Part 3**:
Chapter 16, a third part that teaches *using* orca and afk-fleet to execute the `ready-for-agent` issue backlog Part 2 produced — running agents in parallel worktrees, then unattended (see [ADR-0007](./docs/adr/0007-orca-afk-fleet-execution-part.md)). Like Part 2, the reader uses these tools, does not build them.
_Avoid_: appendix, 番外

**section / 节**:
A heading-level subdivision within a chapter (`##` heading). Not its own file.

**🛠 试一试 box** (en: "🛠 Try it" box):
A short framed prompt inside a section that asks the reader to perform a concrete action on their own machine before continuing. Each one specifies the action and the verification ("you should see X"). Distinct from chapter-end exercises.

**chapter-end exercise / 章末练习**:
A larger composite task placed at the end of (or in the dedicated chapter 9 of) the tutorial. Exercises combine multiple concepts and have a sample answer.

**running project / 主项目**:
The single project the reader builds in chapter 4 and reuses through chapters 5–8: a personal-writing folder containing a few markdown drafts. The chosen domain (α from the design discussion) — chosen because writing is the largest common surface between designer, PM, and general readers.
_Avoid_: example project, demo (those imply throwaway; the running project is reused across chapters)

**first skill / 第一个 skill**:
The "按写作原则审稿" skill the reader hand-writes in chapter 6. Single-file SKILL.md that applies a short set of writing rules to drafts in the running project. Specifically refers to *this* skill in *this* tutorial, not the general concept of "a beginner's first skill."

### Product & platform terms

**Claude Code**:
Anthropic's coding agent. It runs across several surfaces — the CLI (terminal), the Claude desktop app, the web, and IDE extensions — all driving the *same* agent. **This tutorial teaches the CLI surface specifically** (see [ADR-0003](./docs/adr/0003-cli-not-desktop-app.md) for why). Always written exactly "Claude Code" — never translated, never abbreviated to "CC" in prose.
_Avoid_: CC, Claude CLI, Claude 命令行; also avoid defining Claude Code *as* "the CLI" — the CLI is one surface, not the thing itself.

**skill**:
A Claude Code skill — a unit of reusable, automatically-triggered behavior defined by a `SKILL.md` file in a known directory. Always lowercase in prose, never translated (because `SKILL.md` and `/skill-creator` are English in the actual tool — translating in prose would create a mismatch between what the reader reads and what they type).
_Avoid_: 技能, 能力, ability, plugin

**SKILL.md** / **CLAUDE.md** / **AGENTS.md**:
File names. Written in uppercase as shown, never translated, never wrapped in quotes in prose (just inline code where it appears).

**session / 会话**:
One Claude Code conversation, started by running `claude` in a directory. The directory becomes the session's working directory. Translate to 会话 in Chinese prose.
_Avoid_: conversation, chat, thread

**working directory / 工作目录**:
The directory where `claude` was launched. The session can read and write files relative to it.

**prompt**:
Text the reader sends to Claude. Keep "prompt" in both languages — the Chinese AI community has settled on it.
_Avoid_: 提示词, 提示, instruction

**trigger** (verb) / **触发**:
What happens when a skill's description matches the current context and Claude invokes the skill.

**trigger phrase / 触发关键词**:
The substrings or topic cues in a skill's `description` field that Claude pattern-matches against.

**agent / subagent / hook / MCP**:
Keep English in both languages. These are either acronyms (MCP) or terms with no settled Chinese translation in the Claude Code community.

**tool / 工具**:
A capability Claude invokes during a session (e.g. Read, Edit, Bash). Translate to 工具 in Chinese prose.
_Avoid_: function (in this context), 函数

**progressive disclosure / 渐进式展开**:
The skill design pattern where SKILL.md stays small and references larger sibling files that Claude reads only when needed. Translate to 渐进式展开 in Chinese prose.

### Version control terms

The tutorial introduces these in the sharing chapter. The reader never types these commands — Claude Code runs them on request (see [ADR-0004](./docs/adr/0004-git-content-scope.md)). So the reader's encounter with these words is mostly *reading them in Claude's output*, which is why the command-like terms stay English (matching what Claude prints), and only the umbrella concepts translate.

**version control / 版本管理**:
The umbrella concept: keeping a tracked history of changes to a folder so you can see what changed and roll back. Translate to 版本管理 in Chinese prose.

**git**:
The version-control tool Claude Code drives under the hood. Keep English, lowercase, never translated. The reader does not learn git's command syntax — only the concepts below and how to ask Claude to act.

**commit**:
A saved checkpoint of the skill folder. Keep English; gloss as 存档点 on first use in Chinese prose. Used as both noun and verb ("让 Claude commit 一下").
_Avoid_: 提交 (don't translate — the reader sees Claude say "committed")

**diff**:
What changed between two commits. Keep English; gloss as 改了什么 on first use.

**push / clone**:
**push** = publish your commits to GitHub; **clone** = copy a GitHub repo down to a machine (how someone else *installs* a shared skill). Keep both English; gloss on first use (push≈发布, clone≈拷一份). 
_Avoid_: 推送 / 克隆 as the canonical form — gloss once, then use English.

**repository / repo / 仓库**:
A folder under version control, optionally published to GitHub. Here, one shared skill = one repo. Use 仓库 in Chinese prose; "repo" acceptable in passing.

**GitHub**:
The hosting service skills are published to and shared from. Always written exactly "GitHub". Distinct from `git` (the tool) — do not conflate.

**gh**:
GitHub's official CLI, installed in the sharing chapter (`brew install gh`) and used for the one-time `gh auth login` browser login. Keep English, lowercase.

### Engineering-skills terms (进阶篇 / Part 2)

These appear only in chapters 11–15 and 17. Most are borrowed engineering vocabulary; the policy mirrors the rest of the glossary — keep command-like and field names English, translate umbrella concepts.

**engineering skill suite / 工程 skill 套件**:
The open-source `mattpocock/skills` set the 进阶篇 teaches *using* (not building). Refer to the repo exactly as `mattpocock/skills`. The suite is installed with `npx skills@latest add mattpocock/skills`.
_Avoid_: plugin, 插件; calling individual skills "the suite."

**user-invoked / model-invoked**:
The two kinds of skill in the suite. **user-invoked** skills run only when the reader types `/command` (their `SKILL.md` carries `disable-model-invocation: true`); **model-invoked** skills can also be triggered by Claude on its own. The five skills taught in Part 2 are all user-invoked. Keep both terms English.

**the five skills**:
Always written as their `/command` form, English, never translated: `/setup-matt-pocock-skills`, `/grill-with-docs`, `/to-spec`, `/to-tickets`, `/improve-codebase-architecture`. (`ask-matt` and others are named in chapter 16 only.)

**agent protocol / agent 协议**:
The per-repo configuration `/setup-matt-pocock-skills` writes — a `## Agent skills` block in `CLAUDE.md` plus `docs/agents/{issue-tracker,triage-labels,domain}.md` — that every later skill reads. Glossed in chapter 11 as the "接线盒 / junction box." Translate the umbrella; keep file names English.

**PRD**:
Product requirements document — the fixed seven-section artifact `/to-spec` synthesizes and files as an issue. Keep the acronym English in both languages.
_Avoid_: 需求文档 as the canonical form (gloss once, then use PRD); spec (narrower).

**issue**:
A unit of tracked work in the project's issue tracker (GitHub Issues here). Keep English; "一个 issue" in Chinese prose.
_Avoid_: ticket (the skills' own prose uses both; this tutorial standardizes on "issue"), 工单.

**triage label / triage 角色**:
One of the five canonical states an issue moves through: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. Keep the label strings English (they are literal labels). `ready-for-agent` is the one the planning pipeline applies.

**vertical slice / 垂直切片** (tracer bullet):
A unit of work that cuts end-to-end through every layer (schema, interface, UI, tests) and is demoable on its own — what `/to-tickets` produces. Contrast with a horizontal (by-layer) slice. Translate to 垂直切片; keep "tracer bullet" English as the gloss.
_Avoid_: 水平切片 as a thing to produce (it's the anti-pattern).

**deep module / shallow module / 深模块 / 浅模块**:
From the `/codebase-design` vocabulary used by `/improve-codebase-architecture`. A module is **deep** when a lot of behaviour sits behind a small **interface**; **shallow** when the interface is nearly as complex as the implementation (the thing to avoid). Translate the module nouns; keep **interface**, **seam**, **adapter**, **leverage**, **locality** English (no settled Chinese forms, and they must match the skill's own report).
_Avoid_: component, service, unit (for module); API, signature (for interface); boundary (for seam).

**sample project / 示例项目**:
The throwaway fixture codebase at `tutorial/sample-project/`, shared (language-neutral) by both `zh/` and `en/` chapter 15, deliberately containing a shallow-module deepening opportunity so the reader can run `/improve-codebase-architecture` against real code. Mirrors how `tutorial/skills/` is shared.
_Avoid_: demo, running project (the running project is Part 1's personal-writing folder — distinct).

### Part 3 execution terms (执行篇)

These appear only in chapter 16. Product and tool names stay English (like `git`, `gh`, `mattpocock/skills`); umbrella concepts gloss once on first use.

**orca**:
Product name (`stablyai/orca`) — a desktop **ADE** that runs coding agents in parallel git worktrees. Keep English, lowercase, never translated; refer to the repo as `stablyai/orca` on first mention. Distinct from the animal. Frame it as an orchestrator built *on* the CLI, never as a "terminus" (see [ADR-0003](./docs/adr/0003-cli-not-desktop-app.md) / [ADR-0007](./docs/adr/0007-orca-afk-fleet-execution-part.md)).

**afk-fleet**:
Tool / skill name (`sunfmin/afk-fleet`) — the maintainer's own skill, built on orca, that works a backlog unattended. Keep English, lowercase, hyphenated, never translated. "AFK" = away-from-keyboard; gloss the expansion once on first use, keep `afk-fleet` as the canonical form.

**ADE**:
Agentic development environment — the category orca belongs to (a desktop app for running a fleet of coding agents). Keep the acronym English; gloss once on first use.

**worktree**:
git terminology (a `git worktree`: a second working copy of one repo on its own branch, in its own folder). Keep English to match what git and orca print; gloss on first use (worktree ≈ 独立工作副本 / 隔离工作区), then use English.

**fleet**:
Umbrella concept: the standing set of parallel workers afk-fleet runs. Keep English as the canonical form; gloss on first use (fleet ≈ 一支并行工作的 agent 舰队). _Avoid_: 集群, 车队.

**launcher / tick / worker**:
afk-fleet's three roles. **launcher** = the session `/afk-fleet` runs in; it authorizes once, then loops. **tick** = one fresh, disposable pass the launcher spawns each cycle (dispatch → gate → merge → exit). **worker** = one Claude Code per `ready-for-agent` issue, in its own orca worktree. Keep all three English; gloss on first use.

**backlog**:
The set of `ready-for-agent` issues Part 2 produces and Part 3 works through. Keep English; gloss on first use (backlog ≈ 待办清单).
_Avoid_: 积压 (wrong connotation).

### Payment & access terms

**Claude Pro**:
Anthropic's $20/month consumer subscription. Includes Claude Code usage under a fair-use cap. The tutorial's recommended payment path.
_Avoid_: Pro plan, subscription (ambiguous)

**Claude Max**:
Anthropic's $100–200/month heavy-use subscription. Mentioned in the chapter 2 sidebar comparison; not the main path.

**API pay-as-you-go**:
Using an `ANTHROPIC_API_KEY` from console.anthropic.com instead of a subscription. Mentioned in the chapter 2 sidebar; not the main path.

### Sample dialogue

> **Reader (after chapter 6)**: "我的 skill 写好了但没被触发是怎么回事？"
> **Tutorial voice**: "把 `SKILL.md` 第一行的 `description` 给我看一下。description 是 Claude 用来匹配 trigger phrase 的字段。如果你的 prompt 里没出现 description 里描述的场景，Claude 就不会把这个 skill 调起来。这就是第 8 章我们要解决的事情。"

The dialogue uses: skill, 触发, SKILL.md, description, prompt, trigger phrase. All consistent with the table above.

## Flagged ambiguities

(none yet)
