# 第 16 章 —— 跑通你的 backlog：用 orca 和 afk-fleet 编排 agent

_上次校对：2026-07，对齐 Claude Code v2.x_

进阶篇结束时，你手上有一份 **backlog**（待办清单）：一堆 `ready-for-agent` 的 issue，切成了垂直切片、按依赖排好了序（第 14 章）。计划是你做的。这一章 —— **执行篇（Part 3）** —— 讲那个显而易见的下一步：*到底谁去实现这份 backlog，他们又在哪儿跑？*

两个工具回答这个问题，而且你是 **用** 它们，不是 **造** 它们（跟进阶篇对那五个 skill 的姿态一样）：

- **orca** —— 底座：让好几个 Claude Code agent **并行跑，每个都在自己那份独立的仓库副本里**。
- **afk-fleet** —— 消费者：一支 **无人值守的 fleet（舰队）**，一条条走这份 backlog，给每个 issue 派一个 worker，把通过的合并掉 —— 全程在你离开键盘的时候进行。

这正是前言许过的那个兑现。当时我说，终端里的 Claude Code 是一块 **积木**，桌面 App 是个 **终点站**。orca 是个桌面 App —— 但它整个工作就是启动并协调一批 **CLI** 的 Claude Code agent。它不是一个你停在那儿的聊天窗口；它是全书里最清楚的一个例子，让你看到这块积木怎么被 **搭成更大的东西**。（它不是在证明 CLI 比桌面 App「更强」—— 而是让 CLI 变得 *可组合*，这是另一个、也更站得住的说法。）

## 先说一个词：worktree

你用 git 存过档、分享过（第 10 章）。再补一个 git 词汇，这一章就通了：

- **worktree** —— 一个仓库的第二份工作副本，挂在自己的分支上、在自己的文件夹里（worktree ≈ 独立工作副本 / 隔离工作区）。平时一个仓库只有一份工作副本，你在里面切分支；worktree 让你把同一个仓库的 *好几份* 检出摆在一起 —— 于是两个 agent 能同时改「同一个项目」，却谁也碰不到谁的文件。

这就是让并行 agent 安全的诀窍：**一个 issue 一个 worktree**。agent A 在它的 worktree 里、在 `issue-12-…` 分支上做 issue #12；agent B 在另一个 worktree 里做 issue #13。谁也看不到对方的半成品。各自做完，各自开一个 pull request。

## orca：让 agent 并行

**orca**（`stablyai/orca`）是一个 **ADE** —— *agentic development environment*（agent 开发环境），一个桌面 App，专门用来同时跑一支编码 agent 的舰队。每个 agent 拿到自己的 worktree 和分支；你在一个窗口里盯着它们全部，挑赢的那个合并。

> 🛠 试一试
>
> 从 `https://onorca.dev/download` 下载 orca，像装普通 Mac App 一样装好。打开它，指向一个你手边的仓库文件夹 —— 进阶篇那个练手仓库最合适，因为它已经有一份 issue backlog 了。
>
> 你应该看到：orca 打开你的仓库，你熟悉的那个 agent（Claude Code）可用，并且有个地方能开 worktree。

> 💡 orca 不只认 Claude —— 它能同时驱动 Codex、OpenCode 等等。本书只关心它跑 **Claude Code**，也就是你已经会用的那个 agent。

现在铺开。别再让一个 session 一条条串着做 issue，给每个打开的 issue 配自己的 agent：

> 🛠 试一试
>
> 给一个 issue 建一个 worktree、在里面起一个 Claude Code（在 orca 里：新建 worktree → 选 issue / 分支名 → 启动 agent），然后对第二个 issue 再来一遍。分别给每个 agent 派活（"implement issue #N"）。
>
> 你应该看到：两个 agent **同时** 在干活，各自在自己的 worktree、自己的分支上，谁也不碰谁的文件。谁先做完，就开一个 PR 给你 review、合并。

核心就这么点事：能看得见的并行。但起每个 agent、合每个 PR，还是你在动手。下一个工具连这一步都替你省了。

## afk-fleet：让 backlog 自己跑起来

**afk-fleet**（`sunfmin/afk-fleet`）是一个 skill —— 本教程作者自己写的、搭在 orca 之上 —— 把「给每个 issue 起一个 agent、把好的合并掉」变成一个常驻、无人值守的循环。"AFK" 是 *away-from-keyboard*（离开键盘）：你指向仓库，授权一次，然后走开。三个部件：

- **launcher** —— 你运行 `/afk-fleet` 的那个 session。它授权一次，然后不停循环。
- **tick** —— launcher 每一轮派生出来的一次性、用完即弃的过程：看一眼 GitHub，给就绪的 issue 派 worker，把绿的合掉，然后退出。（正因为一次性，它才能连跑好几天而没有任何一个 session 会被撑爆。）
- **worker** —— 每个 `ready-for-agent` issue 一个 Claude Code，各自在自己的 **orca worktree** 里，只通过它的 PR 跟你说话。

> 🛠 试一试
>
> 跟你装工程套件一样的方式装它：`npx skills@latest add sunfmin/afk-fleet`。然后在练手仓库的一个 session 里，先跑一次 **空转（dry run）**：
>
> > `/afk-fleet --plan`
>
> 你应该看到：afk-fleet 读出你仓库里就绪的 issue，打印出 **dispatch 计划** —— 它 *会* 挑哪些 issue、按什么顺序 —— 但什么都 **不合并、不改动**。空转不需要任何授权。

空转是看清楚 fleet 眼里那盘棋的安全办法。等你让它真的动手，你要选 **每个 worker 自己走多远** —— 有两档：

- **停在 PR**（不给自动合并授权时的默认 —— 比如 `/afk-fleet --tick` 冷跑）：每个 worker 开好自己的 PR、跑完 gate，就 **停在那儿**。review 和合并由你自己做。派活、worktree、gate 这些累活 fleet 全干了，只是最后一下留给人。
- **自动合进 `main`**（opt-in，挡在一道明确授权后面）：变绿的 PR 无人值守地 squash 合进 `main`。这是完整的 AFK 模式，也是全书让你打开的最有后果的一件事，所以慢慢读：

> ⚠️ 授权自动合并，意味着 `/afk-fleet` 会 **把分支 push 到你的远端，并把变绿的 PR 合进 `main`，而不再每次问你**。这正是它的用途 —— 无人值守就是无人值守 —— 但你只应该在「自动合进 `main` 可以接受」的仓库上授权它（一个练手仓库、或部署前另有把关的项目）。不给这道授权，fleet 就只停在开好的 PR 等你。无论哪档，fleet 的职责 **到 `main` 为止**；再往后的发布，仍是一个单独的、由人来做的步骤。

站在 worker 的 PR 和 `main` 之间的，是那道 **gate（关卡）**。在有 CI 的仓库里，那就是检查变绿。本书自己的仓库没有 CI —— 它是文字 —— 所以它的 fleet 配置（`docs/agents/afk-fleet.md`）改用一道 **独立的对抗式验证（adversarial verification）**：另一个 agent 拿每个 PR 对着 issue 的验收标准重读一遍，在合并前试图 *驳倒* 它，因为机器分不出好文字和错文字。

> 🛠 试一试
>
> 准备好了，就跑 `/afk-fleet`（不带 `--plan`），把它要的自动合并授权给它。（想每个 PR 都自己过一眼？别给这道授权 —— 或者跑一次 `/afk-fleet --tick` 冷跑 —— fleet 就派活、把关，停在开好的 PR。）
>
> 你应该看到：tick 开始派 worker —— 一个就绪 issue 一个 —— 各自在自己的 orca worktree 里；PR 陆续打开；gate 跑起来；变绿的 PR 被 squash 合进 `main`；失败的重试几次，再不行就升级（打标签交给人，附一条说明卡在哪儿了）。blocker 还没合并的 issue 会排队等着。你可以合上笔记本；循环照跑。

> 💡 这不是玩具例子。这个仓库的 backlog —— 包括你正在读的这一章 —— 就是这么跑出来的：一条进阶篇流水线产出这些 issue，一支 afk-fleet 通过 orca worktree 把它们做完。这本书记录了它自己的建造过程。

## 再说一次「为什么是终端」

看看刚刚发生了什么。一个桌面 App（orca）起了一堆终端 agent；一个 skill（afk-fleet）在一个循环里驱动那个 App、把它接到 GitHub 上。这里每一层，都建立在 Claude Code 是一块 **CLI 积木** 之上：一个你能起很多份、能围着它写脚本、能组装进更大机器里的东西。一个你只能停在那儿的聊天窗口，永远做不了这个栈的底座。这就是本书带你走终端那扇门的全部理由 —— 剩下的，第 17 章接着说。

## 小结

- 执行篇回答「进阶篇产出的 backlog 由谁来跑、在哪儿跑」。
- **worktree**：一个仓库挂在自己分支上的第二份工作副本 —— 一个 issue 一个 worktree，是并行 agent 安全的前提。
- **orca**：一个桌面 ADE，让好几个 Claude Code agent 在并行的 worktree 里跑；你盯着、合并。它是积木论的兑现，不是终点站。
- **afk-fleet**：作者自己的 skill，搭在 orca 上 —— launcher 派生一次性的 tick，给每个 `ready-for-agent` issue 派一个 worker、给每个 PR 把关；授权了就把绿的无人值守自动合并，不授权就停在 PR。
- 永远先 `/afk-fleet --plan`。合并是可选的：**停在 PR**（默认 —— 你自己 review、合并）或 **自动合进 `main`**（opt-in，挡在一道授权后面）；只在可接受的地方授权自动合并。那道 gate（CI，或者对文字用对抗式验证）才是护住 `main` 的东西。
- 两个工具你都是用，不是造。

## 下一章

[第 17 章 —— *下一步*](./17-next-steps.md)。这本书要教的到此为止 —— 第一部分建好并分享了一个 skill，进阶篇规划了真实的活，执行篇把它跑通。最后一章是出口匝道：还有什么没教，以及那些更大的门后面是什么。
