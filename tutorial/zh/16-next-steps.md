# 第 16 章 —— 下一步

_上次校对：2026-07，对齐 Claude Code v2.x_

你已经读完这本书。你会在终端里导航，会跑 Claude Code，会手写一个 `SKILL.md`，会用渐进式展开把它拆成多文件，也会用 `/skill-creator` 通过对话设计新的 skill；进阶篇里，你还用一套专业 skill 跑通了「立协议 → 逼成决策 → 综合 PRD → 切成 issue」这条规划流水线，并对已有代码做过一次架构深化。这本书要教的，到此为止。

这一章是 **off-ramp（出口匝道）**。下面列的话题，这一章都不教 —— 每一个都是另一本书。这里的目的只是告诉你每扇门后面是什么，让你自己决定下一个推开哪一扇。

## Anthropic 官方文档

**Claude Code docs** —— `https://docs.anthropic.com/claude-code`（从这个根入口进，文档结构偶尔重组，从根目录导航最稳）。

- 门后是什么：CLI 的命令、配置、环境变量、feature flag 的事实来源。
- 适合谁：你，每次本书教你的东西和实际表现对不上的时候；每次你想知道某个特性到底存不存在的时候。

## 这套 engineering-skills 套件里还没教的部分

**`mattpocock/skills`** —— https://github.com/mattpocock/skills

进阶篇（第 11–15 章）只教了套件里的五个 skill：`/setup-matt-pocock-skills`、`/grill-with-docs`、`/to-spec`、`/to-tickets`、`/improve-codebase-architecture`。套件里还有不少没展开的门：

- **`/tdd`** —— 红-绿-重构的测试驱动开发：先写一个会失败的测试，再让代码通过它，给 agent 一条稳定的反馈回路。
- **`/diagnosing-bugs`** —— 有纪律的排错循环：复现 → 最小化 → 假设 → 埋点 → 修 → 加回归测试。
- **`/triage`** —— 把 issue 沿一个状态机推进（第 11 章那五个 triage 角色就是给它用的）。
- **`/handoff`** —— 把当前对话压缩成一份交接文档，让另一个 agent 接着干。
- **`ask-matt`** —— 拿不准该用哪个 skill 时问它，它帮你路由。

- 适合谁：你，当进阶篇那条规划流水线已经顺手、想往「写代码 + 测代码 + 修代码」继续铺的时候。
- 怎么跟进：仓库 README 里有作者的 newsletter，新 skill 和改动都在那儿发。

本仓库根目录下的 bootstrap case study（[`BOOTSTRAP-CASE-STUDY.md`](../../BOOTSTRAP-CASE-STUDY.md) / [`BOOTSTRAP-CASE-STUDY.en.md`](../../BOOTSTRAP-CASE-STUDY.en.md)）记录了一次从空目录开始、端到端跑完这条流水线的完整 session —— 正是进阶篇那套流程的真实实录。

下面这两扇门，正好接在那条流水线停下的地方。进阶篇把一个模糊的想法变成一份依赖有序的 `ready-for-agent` backlog —— 可是，谁来做这份 backlog、这些 agent 又在哪儿跑？从上往下读：**orca** 是这些 agent 运行所在的并行 worktree 底座，**afk-fleet** 则是在这个底座之上、无人值守地消费这份 backlog 的那支 fleet。

## orca —— 并行跑一队 CLI agent

**orca**（`stablyai/orca`）—— https://github.com/stablyai/orca

- 门后是什么：一个编排器 —— 官方管它叫 ADE（agentic development environment，agent 化开发环境）—— 它把一队（fleet ≈ 一支并行工作的 agent 舰队）CLI 编码 agent（Claude Code 以及其它）同时跑起来，每个都待在自己独立的 git worktree（worktree ≈ 一个仓库的第二份工作副本，各在各的分支上）里，统一在一处（桌面端 + 移动端）追踪。它是个桌面 App，但不是前言里跟"积木"对照的那个"终点站"：它的全部职责，就是把你这本书学会去跑的那些 CLI agent spawn 出来、再协调起来。它是一个由积木搭成的终点站 —— 而这只有在 CLI 可组合的前提下才成立。正因为 Claude Code 是可组合的 CLI，orca 才能把许多个实例扇到各个 worktree 上，再比较、合并出胜出的那一个。这也让它成为本书那条"积木"论点（见下面的"为什么是终端"）最锋利的一个例子。
- 适合谁：你，当一次只跑一个 Claude Code session 已经不够用的时候 —— 当你想让好几个 agent 在各自隔离的分支上并行跑、又统一盯在一个视图里的时候。

## afk-fleet —— 无人值守地消费一份 backlog

**afk-fleet**（`sunfmin/afk-fleet`）—— https://github.com/sunfmin/afk-fleet

- 门后是什么：一支无人值守的 fleet（AFK = away-from-keyboard，离开键盘）自己把一份 GitHub issue backlog 连着做上好几天。一个很薄的 launcher 每个周期 spawn 一个全新的、用完即弃的 "tick"；每个 tick 给每个 ready 的 issue 派一个 worktree 隔离的 Claude Code worker，拿 CI 给每个把关（对本仓库这样的纯文字仓库，还可以再加一道独立的对抗式验证），把绿的 PR 自动合并，失败的先重试、再升级。它消费的，正是上面 `mattpocock/skills` 那条流程产出的 backlog —— `/grill-with-docs` → `/to-spec` → `/to-tickets` 按依赖顺序发布出来的那批 `ready-for-agent` issue —— 而且它的 worker 就跑在 **orca** 的 worktree 上。这个仓库本身就是那个实例：它的 afk-fleet 每仓配置，以及 [ADR-0006](../../docs/adr/0006-orca-afk-fleet-doors.md)，都是这条循环产出的。
- 适合谁：你，当你已经把一个项目拆成一批 ready、依赖有序的 `ready-for-agent` issue，又不想守着每一个、只想让它们被实现并合并的时候。

## Hooks

**Claude Code hooks** —— 在上面的 Anthropic 文档里搜 "hooks"。

- 门后是什么：让你在 session 的某些事件上自动跑自己的 shell 命令 —— 工具调用之前/之后、session 启动时、Claude 停下来时。Hook 能强制策略（"永远不许动 `/etc`"）、注入上下文（"先读这个文件"）、跑副作用（通知、日志）。
- 适合谁：你，当你发现自己每个 session 都在跟 Claude 重复同一句话（"别 push 到 main"、"先跑 lint"），那句话就该写进 hook，而不是再说一遍。

## MCP —— Model Context Protocol

**MCP** —— `https://modelcontextprotocol.io`，以及 Anthropic 文档里的 MCP 章节。

- 门后是什么：一个开放协议，让 Claude 能用结构化方式访问外部工具、数据源、API（Slack、Google Drive、你的数据库、你公司的内部服务）。MCP server 跟 Claude Code 并行跑，对外暴露 Claude 可以调的新工具。
- 适合谁：你，当你想让 Claude Code 读写不在你硬盘上的东西的时候 —— 比如开 Jira ticket、发 Slack、查生产库。

## Subagents

**Subagents** —— 在 Anthropic 文档里搜 "subagents" 或 "Agent tool"。

- 门后是什么：Claude 把一部分任务下放给一个上下文窗口干净的新 agent，干完再把结论汇报回来。适合一个任务会吃掉太多上下文、或者你想并行处理的场景。
- 适合谁：你，当你的 skill 开始处理大型调研、多步重构，或者任何"干净的上下文比连续性更重要"的任务的时候。

## 为什么是终端

前言里我答应过你：终端里的 Claude Code 是一块积木，桌面 App 是个终点站。读到这你该看得见这句话的分量了——这一章上面每一扇门，都是终端这块积木才搭得起来的：

- hook 是在 session 事件上跑你自己的 shell 命令——得有个能跑 shell 的地方。
- MCP server 跟 Claude Code 并行跑——得有个能起后台进程的地方。
- `claude -p` 一行跑完就退、把 Claude Code 串进 cron 或 CI——这些都是把 Claude Code 当成别的程序的一块零件。

桌面 App 那个聊天窗口很好用，但它就停在那：它是你和 AI 对话的终点。终端不是终点，它是你把 AI 接进其它所有工具的接线板。

往前看一点（这是我的判断，不是事实）：AI 正在把工种之间的墙融掉，一个人将来要做的事会越来越溢出他原本那一行。等那天，"能把 AI 接进任何东西"不再是工程师的专长，而是通用素养。你今天熟悉的这块积木，就是那项素养的起点。

## 收尾

本书每一章顶部都有校对时间戳，告诉你这一章的命令最后一次被验证是什么时候。时间戳会漂；Claude Code 会变；上面那些 URL 也终将搬家。当你发现某处对不上时，Anthropic 文档是第一站。然后欢迎回来这个仓库开个 issue，让下一位读者少踩一个坑。

谢谢你读完这本书。现在去做你想做的东西吧。
