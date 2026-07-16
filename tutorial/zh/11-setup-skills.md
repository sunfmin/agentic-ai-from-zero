# 第 11 章 —— 装上工程 skill 套件，给仓库立协议

_上次校对：2026-06，对齐 Claude Code v2.x_

> 🚩 **从这里开始是「进阶篇」。** 前面十章把你从零带到了能写、能分享一个多文件 skill。进阶篇换一个目标：不再教你 **写** skill，而是教你 **用** 一套别人写好的专业 skill —— Matt Pocock 的 `mattpocock/skills` —— 把 Claude Code 从「编程搭子」变成「项目管理搭子」。决策、PRD、ticket、代码架构，都从 Claude Code 里管起来。
>
> 这一篇假设你已经有了第 10 章建好的 GitHub 账号和 `gh`。其余的我们边走边装。

第 8 章你用过一个**别人写好的** skill：内置的 `/skill-creator`。你没去读它的 `SKILL.md`，你只是打了 `/skill-creator` 然后用它。进阶篇里的五个 skill 也是这么用 —— 它们都是你打 `/命令` 才会跑的 skill，跟 `/skill-creator` 一个路子。区别只是：它们不是 Claude Code 自带的，得先装。

这一章干三件事：搞清楚 **为什么** 要这套 skill、把它 **装上**、再跑第一个也是最重要的一个 —— `/setup-matt-pocock-skills`，给你的仓库立好后面所有 skill 都要遵守的「协议」。

## 这套 skill 在解决什么问题

作者把它们的来由总结成几个「AI 编程最常见的翻车现场」。你大概率都撞见过：

1. **「AI 干的根本不是我想要的。」** 你以为它懂你了，结果它建出来的东西跑偏。根因是 **没对齐**。修法：动手前先让 AI **逼问** 你想要什么 —— 这是 `/grill-with-docs`（第 12 章）。
2. **「AI 啰嗦得要死。」** 项目早期，你和 AI 说的不是同一套黑话，于是它用 20 个词讲 1 个词的事。修法：建一份 **共享语言**（术语字典），让决策和代码都从同一套词派生 —— 也内建在 `/grill-with-docs` 里。
3. **「代码不工作。」** 就算对齐了，AI 还是可能产出垃圾。根因是 **反馈回路不够**。修法：类型、测试、红绿重构 —— 套件里的 `/tdd`、`/diagnosing-bugs`（本书不展开，第 16 章给门）。
4. **「我们堆出了一个烂泥球。」** AI 能加速写代码，也就同样加速 **熵增**，代码库越来越难改。修法：定期捞出「浅模块」深化它 —— 这是 `/improve-codebase-architecture`（第 15 章）。

进阶篇聚焦其中五个 skill。前四个串成一条 **规划流水线**，最后一个是面向已有代码的独立入口：

```
模糊想法
   │  /setup-matt-pocock-skills   ← 一次性，给仓库立协议（这一章）
   ▼
有协议的仓库
   │  /grill-with-docs            ← 把想法逼成决策（第 12 章）
   │   → CONTEXT.md、docs/adr/
   ▼
有决策留痕的仓库
   │  /to-spec                    ← 综合成一份 PRD（第 13 章）
   │   → 一个 PRD issue
   ▼
有 PRD 的仓库
   │  /to-tickets                 ← 切成可独立开工的 issue（第 14 章）
   │   → 一堆 ready-for-agent 的 issue
   ▼
一堆能让 agent 直接拿去干的 issue

（另一条独立的路）
已有代码  ──  /improve-codebase-architecture  ──→  架构报告 + 深化（第 15 章）
```

> 💡 **user-invoked vs model-invoked。** 套件里的 skill 分两种。**user-invoked** 的只有你打 `/命令` 才会跑（它们的 `SKILL.md` 里写了 `disable-model-invocation: true`）—— 这五个全是。**model-invoked** 的 Claude 自己也能在合适时机调起来。这个区分的好处：像 `/grill-with-docs` 这种会改一堆文件的「重」操作，永远是你主动发起，不会冷不丁自己跑起来。

## 装上套件

套件用一个叫 skills.sh 的安装器来装。在终端里跑（不在 Claude 的 prompt 里，是在你自己的 shell 里）：

> 🛠 试一试
>
> 输入：`npx skills@latest add mattpocock/skills`
>
> 你应该看到：一个交互式清单，列出仓库里所有 skill，让你勾选要装哪些、装到哪个 agent（Claude Code 等）。
>
> **全选，把整套都装上。** 最省事也最稳 —— 别自己挑，原因见下面的提醒。

> ⚠️ **为什么不能只挑几个装。** 进阶篇真正教你用的，是 `setup-matt-pocock-skills` 加这四个：`grill-with-docs`、`to-spec`、`to-tickets`、`improve-codebase-architecture`。但这些你打 `/命令` 触发的 skill，底下还会调用一批 model-invoked 的「零件」skill —— `grill-with-docs` 会调 `grilling` 和 `domain-modeling`，`improve-codebase-architecture` 还会调 `codebase-design`。只装前面那几个、不装底下的零件，主 skill 跑起来就缺胳膊少腿（逼问不完整、报告出不来）。所以 **直接全选**，别自己挑。

装完确认一下它们到位了：

> 🛠 试一试
>
> 输入：`ls ~/.claude/skills/`
>
> 你应该看到：除了你前几章自己写的 skill（比如 `review-writing`），多出刚装的这几个文件夹。
>
> 然后随便看一个的脑袋：`head -5 ~/.claude/skills/setup-matt-pocock-skills/SKILL.md`
>
> 你应该看到：frontmatter 里有 `name`、`description`，还有 `disable-model-invocation: true` —— 印证上面说的「user-invoked」。

> ⚠️ 装好之后，**开一个新的 `claude` session** 才能用上这些新 skill。老 session 看不到刚装的东西 —— 这跟第 8 章排错清单里那条「改了 skill 要开新 session」是同一回事。

## 起一个练手仓库

进阶篇是 **完整动手** 的：你会在一个真实仓库里跑通整条流水线，真的发出 GitHub issue。为了不弄乱你已有的东西，我们专门起一个练手仓库。

它会承载第 11～14 章。想做什么由你定 —— 后面 grill 的价值，正在于它逼你回答 **你自己这个想法** 的问题。挑一个你真有点想做的小东西（一句话能说清的那种）。本书后面用「**一个记录我想读的东西的读书清单小应用**」当**示例**，好让我能告诉你「你大概会看到什么」；你换成自己的想法就行。

> 🛠 试一试
>
> 在终端里：
>
> > ```
> > mkdir ~/reading-list && cd ~/reading-list
> > claude
> > ```
>
> （文件夹名随你；用你自己想法的名字更好。）
>
> 你应该看到：Claude Code 在一个 **空目录** 里启动。这正是我们要的起点 —— 一张白纸。

## 跑 `/setup-matt-pocock-skills`

这是你在新仓库里跑的 **第一个** skill，而且 **每个仓库只跑一次**。它不写任何业务内容，只做一件事：给这个仓库立好一套「agent 协议」，告诉后面所有 skill 三件事 —— issue 发到哪、triage 用什么标签、项目术语去哪儿找。

> 🛠 试一试
>
> 在 Claude 的 prompt 上输入：`/setup-matt-pocock-skills`
>
> 你应该看到：Claude 先扫一遍当前目录（空的），然后 **一次一个** 地问你三件事，每件都先给一段「这是什么、为什么需要」的解释和一个推荐默认值：
>
> 1. **issue tracker 用哪个？** —— GitHub / GitLab / 本地 markdown / 其它。你前面用的是 GitHub + `gh`，选 **GitHub**。（它可能还会追问「PR 算不算一种需求来源」，练手项目选「否」即可。）
> 2. **triage 标签用什么词？** —— 五个 canonical 角色：`needs-triage`、`needs-info`、`ready-for-agent`、`ready-for-human`、`wontfix`。直接用默认。
> 3. **domain 文档怎么放？** —— 单 context（一个 `CONTEXT.md` + `docs/adr/` 放仓库根）还是多 context。练手项目选 **单 context**。

回答完，它会把要写的东西先给你看一遍再落盘。批准之后看看它建了什么：

> 🛠 试一试
>
> 输入：`ls -R . docs 2>/dev/null` （或者直接让 Claude「列一下你刚建的文件」）
>
> 你应该看到大致这些：
>
> > ```
> > CLAUDE.md                       ← 多了一个「## Agent skills」配置块
> > docs/agents/issue-tracker.md    ← 「issue 在 GitHub，用 gh CLI」
> > docs/agents/triage-labels.md    ← 五个 triage 角色
> > docs/agents/domain.md           ← CONTEXT.md / ADR 该怎么读
> > ```
>
> 翻一眼 `CLAUDE.md`：`cat CLAUDE.md`。你应该看到一个 `## Agent skills` 段，下面三个小节分别一句话指向上面三个文件。

> 💡 如果这个目录本来既没有 `CLAUDE.md` 也没有 `AGENTS.md`，Claude 会问你「该建哪一个」—— 它不会替你拍板。建了之后，它只往里加一个 `## Agent skills` 块，不碰你别的内容。

## 为什么这一步是「接线盒」

`/setup-matt-pocock-skills` 自己什么活都没干 —— 没写一行业务代码、没发一个 issue。但它是后面 **每一个** skill 的接线盒：

- `/to-spec` 和 `/to-tickets` 要发 issue 时，会去读 `docs/agents/issue-tracker.md`，于是知道该调 `gh issue create`，而不是反过来问你「发哪儿」。
- 它们贴「这个 issue 可以让 agent 直接干了」的标签时，读 `docs/agents/triage-labels.md`，于是贴的是 `ready-for-agent` 而不是自己瞎编一个。
- `/grill-with-docs`、`/improve-codebase-architecture` 探索代码前，读 `docs/agents/domain.md`，于是知道去哪儿找术语字典。

不做这一步，后面每个 skill 都得 **自己再问一遍** 「我该把 issue 发哪儿、贴什么标签」，或者干脆瞎猜。花五分钟做一次，省下后面二十次重复对话 —— 这就是它的杠杆。

## 把这一步存档并发布

你已经会用第 10 章学的 git/GitHub 了。让 Claude 把这套协议存个档、推上去 —— 顺手给这个练手仓库建好 GitHub 远端，后面 `/to-spec`、`/to-tickets` 才有地方发 issue。

> 🛠 试一试
>
> 在 prompt 上对 Claude 说：
>
> > 把这些 commit 一下，然后在 GitHub 上创建这个仓库并 push 上去。
>
> 你应该看到：Claude 跑 `git init` / `git add` / `git commit`，问你仓库可见性（public/private）和仓库名，然后用 `gh repo create ... --push` 把它推到 GitHub。它做这些之前会 **确认风险点**（公开还是私有），不会默认就公开。

现在你有了一个 **有协议、已上 GitHub、但还一个字业务内容都没有** 的仓库。下一章开始往里灌「想清楚的决策」。

## 小结

- 进阶篇教你 **用** 一套现成的专业 skill，不是写它们 —— 跟第 8 章用 `/skill-creator` 同一个路子。
- 这五个 skill 都是 **user-invoked**：你打 `/命令` 才跑，不会自己冒出来。
- 装法：`npx skills@latest add mattpocock/skills`，**全选装齐**（这几个 skill 依赖底层的 `grilling` / `domain-modeling` / `codebase-design`，别只挑教到的几个）；装完 **开新 session**。
- `/setup-matt-pocock-skills` 每个仓库 **跑一次**，立好协议（issue tracker / triage 标签 / domain 文档），写进 `CLAUDE.md` + `docs/agents/`。
- 这套协议是后面每个 skill 的 **接线盒** —— 做一次，省掉无数次「issue 发哪儿、贴什么标签」的重复问答。

## 下一章

[第 12 章 —— *把模糊想法逼成决策*](./12-grill-with-docs.md)。你会用 `/grill-with-docs` 对着你那句话想法被逼问一轮，把它挤成一串具体决策 —— 而且决策会被当场写进 `CONTEXT.md` 和 ADR。
