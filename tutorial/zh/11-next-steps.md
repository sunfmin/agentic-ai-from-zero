# 第 11 章 —— 下一步

_上次校对：2026-05，对齐 Claude Code v2.x_

你已经读完这本书。你会在终端里导航，会跑 Claude Code，会手写一个 `SKILL.md`，会用渐进式展开把它拆成多文件，也会用 `/skill-creator` 通过对话设计新的 skill。这本书要教的，到此为止。

这一章是 **off-ramp（出口匝道）**。下面列的话题，这一章都不教 —— 每一个都是另一本书。这里的目的只是告诉你每扇门后面是什么，让你自己决定下一个推开哪一扇。

## Anthropic 官方文档

**Claude Code docs** —— `https://docs.anthropic.com/claude-code`（从这个根入口进，文档结构偶尔重组，从根目录导航最稳）。

- 门后是什么：CLI 的命令、配置、环境变量、feature flag 的事实来源。
- 适合谁：你，每次本书教你的东西和实际表现对不上的时候；每次你想知道某个特性到底存不存在的时候。

## 这套 engineering-skills 工作流

**`mattpocock/skills`** —— https://github.com/mattpocock/skills

- 门后是什么：一套开源的 Claude Code skills（`grill-with-docs`、`to-prd`、`to-issues`、`tdd` 等等），把 Claude Code 从"编程搭子"扩展成"项目管理搭子" —— 决策、ticket、测试都从 Claude Code 里管。
- 适合谁：你，当你用 Claude Code 做完一个真实项目之后，想开始管理项目本身（不只是写代码）的时候。

本仓库根目录下的 bootstrap case study（[`BOOTSTRAP-CASE-STUDY.md`](../../BOOTSTRAP-CASE-STUDY.md) / [`BOOTSTRAP-CASE-STUDY.en.md`](../../BOOTSTRAP-CASE-STUDY.en.md)）记录了一次从空目录开始、端到端跑完这套 skills 的完整 session。

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
