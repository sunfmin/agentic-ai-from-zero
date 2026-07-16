# 从零搭一个 Claude Code 项目：一次完整 session 复盘

> _Last calibrated: 2026-05, against Claude Code v2.x_

## 这份文档是什么

2026 年 5 月 28 日，我在一个 **完全空的目录** 里启动 Claude Code，目标是搭一个"从 0 开始教读者用 Claude Code 和写 skill"的双语教程仓库。整个过程一共调了 4 个 skill，回答了 14 个设计问题，提交 2 次代码，发布 1 份 PRD + 11 个可独立 grab 的 GitHub issue。

这份文档是这场 session **从开头到结束的逐步复盘** —— 我具体怎么问、调了什么 skill、Claude 怎么回答、每一步产出什么、为什么有用。

谁该读它：
- 想用 AI 把"从模糊想法到可执行任务"这段路跑得规范化的人
- 听说过 Matt Pocock 的 engineering skills 但不知道怎么串起来用的人
- 觉得"AI 帮我写代码"还不够、想用 AI 帮自己 **做规划** 的人

---

## 起点

一台 Mac，一个空目录，装好的 Claude Code，Matt Pocock 的一套 engineering skills 已经放在 `~/.claude/skills/`。

```
$ pwd
/Users/sunfmin/Developments/agentic-ai-from-zero
$ ls
(empty)
```

我想做的事：**在这个仓库里写一本教程，从零基础（只用过 GUI、从没用过命令行）讲到能写多文件 Claude Code skill**。但我心里只有这一句话 —— 没有大纲、没有目录结构、没有决定语言、没有想清楚读者是谁、没有决定操作系统。

下面是 Claude Code 怎么把这句话变成一份 PRD 和 11 个可执行 issue 的全过程。

---

## 用到的 4 个 skill（按顺序）

1. **`/setup-matt-pocock-skills`** —— 给仓库设好 agent 们要遵守的"协议"（issue tracker 在哪、triage label 用什么、domain 文档怎么读）
2. **`/grill-with-docs`** —— 对着我的初步想法 **逼问 14 个具体问题**，把模糊想法挤成具体决策；过程中把决策沉淀进 `CONTEXT.md` 和 `docs/adr/`
3. **`/to-spec`** —— 把所有决策综合成一份 spec（你可能叫它 PRD），发成 GitHub issue
4. **`/to-tickets`** —— 把 PRD 切成 11 个可独立 grab 的 vertical slice，全部发成 issue

---

## 第 1 步：给仓库装上"agent 协议" — `/setup-matt-pocock-skills`

### 我说了什么

```
/setup-matt-pocock-skills with github issues, and others with default
```

意思：issue 用 GitHub，其他配置走默认值。

### Claude 做了什么

先扫了一遍当前目录（空的），然后因为既没 `CLAUDE.md` 也没 `AGENTS.md`，问我"该建哪一个"。我选了 `CLAUDE.md`。

接着写了 4 个文件：

```
CLAUDE.md                          ← Agent skills 配置入口
docs/agents/issue-tracker.md       ← "issue 在 GitHub，用 gh CLI"
docs/agents/triage-labels.md       ← 5 个 canonical triage 角色
docs/agents/domain.md              ← CONTEXT.md / ADR 的读法
```

### 为什么这一步重要

后面用的所有 skill（grill、to-spec、to-tickets）都会 **读这几个文件**，从而知道：
- issue 该用 `gh issue create` 还是写在 `.scratch/` 还是别的
- 触发"ready for AFK agent"该贴哪个 label
- 项目术语去哪儿找

不做这一步，后面每个 skill 都会"自己再问一遍"或者瞎猜。做了之后，整个 session 里 Claude **没有再问过任何一次** "我该把这个 issue 发哪儿、贴什么 label"。

---

## 第 2 步：建 GitHub 仓库

### 我说了什么

```
创建 GitHub 仓库，然后 push 上去。
```

### Claude 做了什么

问了我两件事 —— 仓库可见性（Public）和仓库名（用目录同名 `agentic-ai-from-zero`） —— 然后：

```bash
git init -b main
git add CLAUDE.md docs/
git commit -m "Initial commit: set up agent skills config"
gh repo create agentic-ai-from-zero --public --source=. --remote=origin --push
```

第一次 commit `a7ce8d8` 推到了 https://github.com/sunfmin/agentic-ai-from-zero

### 这一步的小细节

我说的是"创建仓库 + push"，没说"先 git init" —— Claude 自己看到目录里没 `.git` 就补上了。它 **确认了风险点**（visibility 公开/私有）才创建，没有默认 public 就跑。

---

## 第 3 步：把"我想做一本教程"问成 14 个具体决策 — `/grill-with-docs`

### 我说了什么

```
/grill-with-docs 我想在这里面创建一个从 0 开始的教程，
给那些 0 基础、只用过 GUI 工具、从来没有用过命令行工具的用户，
教他们如何使用 Claude Code 和创建 skill 的教程。
```

### `grill-with-docs` 是什么

它的本职工作是 **逼问**：一次一问，每个问题先给推荐答案 + 理由，等我确认/反对/调整再走下一题。期间不停把已经定下的领域术语写进 `CONTEXT.md`，把"难逆转 + 未来读者会困惑 + 真的有取舍"的决策做成 ADR 放在 `docs/adr/`。

### 14 个问题流水账

下面是 Claude 问的每一题、我的回答、最终落点：

| # | 问题 | 我的答 | 落点 |
|---|---|---|---|
| 1 | 目标读者用什么操作系统？ | macOS | 后来变 ADR-0001 |
| 2 | 教程的终点是什么？（A 会对话 / B 会写第一个 skill / C 会写"像样的" skill） | C，**用双语吧** | CONTEXT.md |
| 3 | "双语"具体长什么样？（同页对照 / 分目录 / 术语标注） | 按推荐：分目录 `zh/` + `en/` | CONTEXT.md |
| 4 | 载体？（纯 markdown / 静态站点 / 单文件长文） | 按推荐：纯 markdown | — |
| 5 | 读者是谁？（设计师 / PM / 纯好奇 / 已用过 GUI AI 工具） | **D，但例子要覆盖 A 和 B** | CONTEXT.md |
| 6 | 读者在哪里？（大陆 / 海外华人 / 不限定） | 按推荐：海外华人 + 已搞定 VPN/海外卡的大陆读者 | 后来变 ADR-0001 |
| 7 | 11 章大纲对吗？ | 按推荐 | CONTEXT.md |
| 8 | 主项目用什么场景？（个人写作 / 设计 brief / 会议纪要） | 按推荐：个人写作 | CONTEXT.md |
| 9 | 第 2 章付费方式怎么推？ | 按推荐：主推 Pro + 侧栏列 Max/API | CONTEXT.md |
| 10 | 仓库怎么布局？ | 按推荐：`tutorial/zh/` + `tutorial/en/` | CONTEXT.md |
| 11 | 动手强度？（纯读 / 边读边做 / 项目驱动） | 按推荐：边读边做（🛠 试一试框） | CONTEXT.md |
| 12 | 术语翻译策略？（全译 / 全保 / 分级） | 按推荐：分级策略（命令英文、通用词中文、新生词保留英文） | CONTEXT.md |
| 13 | 版本策略？（不锁 / 锁定 / 不锁 + 章首校对时间戳） | 按推荐：不锁 + 时间戳 | 后来变 ADR-0002 |
| 14 | 要不要建 ADR？建几个？ | 按推荐：建两个（scope + versioning） | docs/adr/0001、0002 |

### Claude 每题都给了什么

不是干巴巴的"选 A/B/C 吧"。每一题都给了：

- **问题背景**（这个决定为什么是个决定）
- **3~4 个候选** 及各自的代价
- **明确的推荐** 及推荐的理由（一般 4~5 条 bullet）
- **拒绝某些候选的理由**（防止我没想清楚就选）

举例，第 1 题的推荐部分：

> **我的推荐：先只做 macOS。** 理由：
> 1. 你（sunfmin）自己在 Mac 上，写得动、能现场验证
> 2. 对零基础用户来说，Mac 上路径最短、踩坑最少
> 3. Windows 分支需要先教 WSL2，等于在主线之前插一整章异步任务
> 4. 后面真要支持 Windows，可以单独开一个"Windows 篇"

每一题我看完都能在 30 秒内判断"对/不对"，几乎不需要现场思考 —— 因为 Claude 已经把候选列出来 + 标好"为什么不选 X"。

### Grill 期间的副产品

第 12 题（术语策略）刚答完，Claude 没等我提醒就 **自己** 新建了 `CONTEXT.md`，把已经定下的"读者画像""章节结构""主项目""术语表""payment 路径"全部沉淀进去 —— 这是 `grill-with-docs` 文档里规定的"resolve 一个 term 就 update CONTEXT.md inline"的执行。

第 14 题答完，建了 2 个 ADR：

- `docs/adr/0001-tutorial-scope.md` —— macOS only + 假设读者有 VPN/海外卡
- `docs/adr/0002-versioning-policy.md` —— 不锁版本 + 每章校对时间戳

### 提交

我说"提交并且 push"，Claude 把 `CONTEXT.md` + 两个 ADR 一并 commit（`904edf9`）推到 GitHub。

### 为什么这一步重要

整本教程 **还没写一个字**，但它几乎所有可能引起后期返工的争议都已经定了。零基础读者是谁？哪种操作系统？怎么 bilingual？术语用哪种？版本怎么管？没有 grill，这些问题要么在写完 3 章后被读者反馈撞出来，要么在我每次开新章节时反复纠结。

更重要：决策 **有留痕**。`CONTEXT.md` 是术语字典 + 读者画像；ADR 是难逆转决定的理由书。半年后我自己回来、或者别的协作者第一次进仓库，都能看到"这本教程为什么这样设计"。

---

## 第 4 步：把所有决策综合成一份 PRD — `/to-spec`

### 我说了什么

```
/to-spec
```

光秃秃一个命令，没有任何额外说明。`to-spec` 的设计就是 **不要面试用户、直接综合已有 context**。

### Claude 做了什么

第一步先 **切模块**，给我看候选：

- M1 仓库骨架与章节规范（深模块）
- M2 中文章节内容
- M3 英文镜像
- M4 示例 skill 制品（深模块）
- M5 主项目 starter

明确标了 **哪两个是深模块**（接口稳、独立可验证），并推荐 **只对 M1 + M4 写自动化验证**（其他模块没法自动测，因为"在一台干净 Mac 上能不能装 Homebrew"这种事自动化覆盖不到真实新读者）。

我答"按推荐"，Claude 直接写了 PRD 并 publish 成 GitHub issue #1，标签 `ready-for-agent`：

https://github.com/sunfmin/agentic-ai-from-zero/issues/1

### PRD 内容

按 `to-spec` 模板（problem / solution / user stories / implementation decisions / testing decisions / out of scope / further notes）：

- **26 条 user stories**，覆盖读者、维护者、未来贡献者三类视角
- **5 个模块的职责边界**，每个模块的 interface 是什么
- **11 章大纲**（已在 grill 里冻结）
- **跨章节约定**（calibration header、🛠 box 形态、术语表、命名规则）
- **测试策略**（M1 lint 脚本 + M4 skill 验证脚本，其他不自动测）
- **out of scope**（Windows / 大陆网络 / hooks / MCP / 视频）—— 反向定义减少未来口水

### 顺便：补齐了 5 个 canonical triage label

之前 setup 阶段只是把 label **约定** 写进了 `docs/agents/triage-labels.md`，GitHub 仓库本身还没创建这些 label。`to-spec` 在创建 issue 时调 `gh label list` 发现少了 4 个（`needs-triage`、`needs-info`、`ready-for-agent`、`ready-for-human`），就直接补创了，再发 issue。

这是个小细节但很关键 —— Claude 检测到 **协议和现实的 gap** 之后主动补上，没让我手动一个个 `gh label create`。

### 为什么这一步重要

PRD 不是手写的、也不是"AI 帮我润色一下"的产物。它是 **前面 grill 里所有决策的机械综合**。换句话说，**真正的设计工作在 grill 里就做完了**，PRD 只是把决策装进一个 AFK agent 能直接拿来干活的模板里。

如果跳过 grill 直接 `/to-spec`，得到的会是一份"听起来合理但每条都泛泛"的 PRD —— 因为决策从没具体下来过。

---

## 第 5 步：把 PRD 切成 11 个 vertical slice — `/to-tickets`

### 我说了什么

```
/to-tickets
```

又是光秃秃一个命令。`to-tickets` 自己知道去读 issue #1。

### Claude 做了什么

按 **tracer bullet**（每个切片端到端切穿所有层，不是按层切）原则，提出 11 个切片：

| # | 切片 | 类型 |
|---|---|---|
| #2 | Tracer: scaffold M1 + chapter 0 | **HITL** |
| #3 ~ #11 | 一章一切片，配套的 skill artifact 和 starter 内嵌 | AFK |
| #12 | Chapter 10 (next steps) | AFK（仅依赖 #2） |

关键判断：

- **切片 #2 标 HITL**，因为后面 10 个切片都建在它的 conventions 上 —— 你最好在合并它的 PR 时亲眼看一遍
- **zh 和 en 不拆切片** —— 同一章一起做（PRD 已写"Chinese first → calibrate → English mirror"）
- **依赖严格线性**（除了 #12 chapter 10 不依赖前面的具体章节，只依赖 tracer）
- **M4 skill artifact 内嵌进 ch6/7 的切片** —— 章节和它产出的 skill 是同一份东西的两面，分开切会让其中一边领先另一边卡住

我答"按推荐"，Claude 按依赖顺序逐个发了 11 个 issue（#2 到 #12），每个 issue 都引用了对应的 blocker。

### 每个 issue 长什么样

模板（`to-tickets` 强制的）：

- **Parent**: #1（PRD）
- **What to build**: 端到端行为描述，**不写具体文件路径**（容易过期）
- **Acceptance criteria**: checkbox list，每条都可验证
- **Blocked by**: 上一个 issue 的引用

每个 issue 大小都是"一个 AFK agent 一两天能干完"的。

### 为什么这一步重要

PRD 是"全景图"，一个 agent 看了不知道从哪儿下嘴。切成 11 个 vertical slice 之后：

- 每个 slice 都有明确的入口（blocker）和明确的出口（acceptance criteria）
- agent 可以 **并行** 拿走互不依赖的 slice（#12 chapter 10 和主链可以并发）
- HITL/AFK 标签告诉 agent 哪些它能直接干完、哪些需要人来 review
- "vertical slice" 保证每个 slice 合并完都是 **仓库的一个 demoable 增量**，不是半成品

---

## 整个 session 产出清单

### 仓库文件（已 push 到 GitHub）

```
CLAUDE.md                              ← agent 协议入口
CONTEXT.md                             ← 双语术语字典 + 读者画像
docs/
├── adr/
│   ├── 0001-tutorial-scope.md         ← macOS only + 海外读者
│   └── 0002-versioning-policy.md      ← 不锁版本 + 章首时间戳
└── agents/
    ├── issue-tracker.md               ← GitHub + gh CLI
    ├── triage-labels.md               ← 5 个 canonical roles
    └── domain.md                      ← CONTEXT.md / ADR 读法
```

### GitHub 仓库

- 1 个 public repo：https://github.com/sunfmin/agentic-ai-from-zero
- 2 次 commit：`a7ce8d8`（initial setup）、`904edf9`（lock scope and terminology）
- 1 份 PRD（issue #1）+ 11 个 slice issues（#2 ~ #12）
- 5 个 triage label（needs-triage / needs-info / ready-for-agent / ready-for-human / wontfix）

### 决策留痕

- 14 个具体设计决策都在 `CONTEXT.md` 或两个 ADR 里有据可查
- 没有任何"我当时是这么想的但没写下来"的暗箱

---

## 这个流程的好处（你为什么该照着做）

### 1. 我从来没写过散文，决策却已经定到了"AFK agent 可以直接拿去开工"的颗粒度

整个 session 我打字加起来大概 200 字（大部分回复就是"按推荐"）。但最后产出的是一份能让另一个不在场的 agent 拿去开 11 个 PR 的 spec。

### 2. 决策不是凭一时拍板，是被 Claude 推着"你打算怎么处理 X"答出来的

Grill 强迫"每一个分叉都得做选择"。我没法跳过"大陆读者要不要支持"这种问题然后让它隐形地咬我，因为 Claude 会问。

### 3. 决策留痕是免费的副产品，不是额外工作

`CONTEXT.md` 和 ADR 不是"做完决策回头补的文档"，是 grill 过程里 **当场写的**。我不需要花一个下午"把决策整理成 ADR"。

### 4. PRD 和 issue 是机械产物，不是创造性产物

`/to-spec` 和 `/to-tickets` 没有再做新设计 —— 它们只是把 grill 已经定下的决策塞进 PRD 模板和 issue 模板。所以这两步快且不容易出错。如果 grill 不够深入，PRD 就会泛泛 —— 但这是 grill 的问题，不是 to-spec 的问题。

### 5. 协议（CLAUDE.md + docs/agents/）是其他 skill 的"接线盒"

后面每个 skill 都默默地读 `docs/agents/issue-tracker.md` 和 `docs/agents/triage-labels.md`。我没有再说过一次"issue 发到 GitHub、label 用什么"。这是 setup 的杠杆。

---

## 你怎么复用这套流程

### 起手式

1. 装 Claude Code + Matt Pocock 的 skills（`mattpocock/skills` 的 README 里有装法）
2. `cd` 进你的（可能是空的）项目目录
3. `claude`

### 推荐顺序

```
/setup-matt-pocock-skills              ← 给仓库装协议
（创建 GitHub 仓库 + push）             ← 让 agent 有地方发 issue
/grill-with-docs <你想干什么的一句话>    ← 把模糊想法变成具体决策
/to-spec                               ← 把决策综合成 PRD
/to-tickets                            ← 把 PRD 切成可执行 issue
```

### 关键 1：grill 要愿意被问

grill 的价值在于 **让你回答你本来不会主动想清楚的问题**。如果对每个问题你都"按推荐"也行（说明 Claude 的推荐确实是合理的默认），但更有价值的是某些问题你回答"不，我想要 X 而不是 Y" —— 那是 Claude 没法替你做的部分。

### 关键 2：不要跳过 setup

不装 `docs/agents/*`，后面的 skill 每个都要重新问一遍"我该把 issue 发哪儿、label 用什么"。这是 5 分钟一次性投入，省下 20 次重复对话。

### 关键 3：把决策留痕当成默认

`CONTEXT.md` 和 ADR 是你 **未来的自己** 最感激的东西。半年后你回来、或者有人加入、或者你想接一个 AI agent 让它继续干 —— 它们都靠这些文档"快速进入状态"。

---

## 一份给读者的"用 Claude Code 项目管理"心智模型

```
模糊想法
   │
   │ /setup-matt-pocock-skills  ← 一次性，立协议
   │
   ▼
有协议的空仓库
   │
   │ /grill-with-docs           ← 把想法挤成决策
   │  → CONTEXT.md, ADR/
   │
   ▼
有决策留痕的仓库
   │
   │ /to-spec                   ← 综合成 PRD
   │  → issue #N (the PRD)
   │
   ▼
有 PRD 的仓库
   │
   │ /to-tickets                ← 切成 vertical slice
   │  → issues #N+1...
   │
   ▼
一堆 ready-for-agent 的 issue
   │
   │ AFK agent 干活
   │
   ▼
PR、merge、calibration、下一轮
```

每一步都在 **收缩自由度**：模糊想法 → 决策 → PRD → issue。每一步都有产物可见，每一步都有 commit 可追溯。

---

## 这个仓库本身之后会怎么发展

按发出的 issue 顺序：

1. Tracer slice (#2) 把 M1 conventions 立起来 —— **HITL**，需要人在 PR 时审一遍
2. Slice #3 ~ #11 串成主链，逐章 AFK 执行
3. Slice #12 (Chapter 10 next-steps) 可以跟主链并行

Issue #1 的 PRD 是这个仓库未来所有变更的"宪法"；新的需求要么走 PRD-prefix issue 单独开（用 `/to-spec`），要么作为 sub-task 挂到 issue #1 之下（用 `/to-tickets`）。

---

最后说一句：**这份文档本身也是 session 的一部分**。我让 Claude "把这个 session 从开头到现在的整个过程写成一个东西" —— 它写了你正在看的这篇。所以这份文档不仅是 case study，也是一个证据：这套流程的"产出物"质量足够直接拿去演示。
