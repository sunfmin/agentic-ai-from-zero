# Agentic AI from Zero — Tutorial Context

This repo hosts a bilingual (Chinese / English) tutorial that takes a reader from "never used the command line" to "can write a multi-file Claude Code skill." This glossary defines the vocabulary the tutorial uses, so prose and code stay consistent across both languages and all chapters.

## Language

### Reader & audience

**reader / 读者**:
The target audience archetype: a person who has used GUI AI tools (ChatGPT web, Claude.ai) but never used the command line, on macOS, with access to international payment and to anthropic.com.
_Avoid_: user, audience, learner (unless explicitly meant in a different sense)

**D-type reader**:
Specifically: an ex-GUI-AI user being upgraded to CLI. The tutorial's main narrative ("from the chat box to the command line") is written for this archetype. Designers (A) and PMs (B) are example contexts the tutorial covers, not separate archetypes.

### Tutorial structure

**chapter / 章**:
One of the 11 numbered units (0 through 10). Each chapter is one markdown file under `tutorial/zh/` and a mirror file under `tutorial/en/`. File names are `NN-slug.md` where `NN` is a two-digit number and `slug` is a short English identifier (same slug in both languages).
_Avoid_: lesson, section (section means something narrower — a heading within a chapter)

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
Anthropic's CLI agent. Always written exactly "Claude Code" — never translated, never abbreviated to "CC" in prose.
_Avoid_: CC, Claude CLI, Claude 命令行

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
