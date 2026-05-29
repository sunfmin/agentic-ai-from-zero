# 第 10 章 —— 版本管理与分享你的 skill

_上次校对：2026-05，对齐 Claude Code v2.x_

第 7 章你把那个审稿 skill 拆成了多文件。现在它是你的东西了 —— 一个有 `SKILL.md`、有 `principles.md` 的真家伙。这一章做两件事：给它**存档**（这样你随时能退回上一版），再把它**发到网上**分享给别人。

你不会在这一章学 git 命令。git 是一个**版本管理**工具 —— 帮你记住一个文件夹"每一次改动长什么样"。但你不用亲手敲它：你只要开口，Claude Code 替你跑。你要学的是三个概念，外加"怎么跟 Claude 说"。

## 给 skill 存个档

想象一个**存档点**（git 里叫 **commit**）：就像游戏里的存档，把"此刻这个文件夹的样子"整个记下来。以后不管怎么改，你都能回到任何一个存档点。

我们让 Claude 给你的 skill 文件夹建第一个存档点。

> 🛠 试一试
>
> 在 `~/.claude/skills/review-writing/` 这个文件夹里启动一个 session（`cd ~/.claude/skills/review-writing`，然后 `claude`），跟它说：
>
> > 帮我把这个文件夹用 git 管起来，建第一个 commit。
>
> 你应该看到：Claude 跑几条 git 命令（`git init`、`git add`、`git commit`），然后告诉你第一个存档点建好了。

⚠️ 一个要避开的坑：**只给这一个 skill 文件夹存档，别给整个 `~/.claude/skills/` 存档。** 那个目录装着你所有的 skill，混在一起没法单独分享。一个 skill = 一个独立的存档仓库（**repo**）。

存好之后，改点东西试试。比如让 Claude 往 `principles.md` 里加一条原则。然后问它：

> 跟上一个存档点比，我改了什么？

Claude 会给你看一个 **diff** —— 哪几行加了、哪几行删了。这就是版本管理最日常的用处：**看清楚到底改了什么**。

如果你不喜欢这次改动，直接说：

> 退回上一个存档点。

skill 就回到上一版了。这就是"安全网" —— 你可以放心大胆改，反正退得回去。

## 发到 GitHub 分享

存档是存在你自己电脑上的。要把 skill 分享给别人，得把它发到 **GitHub** —— 一个放代码和文件、供人下载分享的网站。

这需要两样东西：一个 **GitHub 账号**（免费），和一个叫 **gh** 的小工具（GitHub 的官方命令行）。

如果你还没有 GitHub 账号，现在去 github.com 注册一个，免费，几分钟。

然后装 gh：

> 🛠 试一试
>
> 输入：`brew install gh`
>
> 你应该看到：Homebrew 下载、安装 gh，最后一行说装完了。（还记得第 2 章的 Homebrew 吗？就是它。）

装好之后，让 gh 认识你的 GitHub 账号。这一步**不是** 🛠 框 —— 它会打开浏览器，验证方式是"浏览器里登录成功"，跟第 2 章登录 Anthropic 那次一样。

输入 `gh auth login`，按它的提示走（选 GitHub.com、选浏览器登录），在弹出的浏览器页面里授权。完事之后终端里会显示一条登录成功的确认。

现在万事俱备。回到你 skill 文件夹的 session，跟 Claude 说：

> 帮我把这个 skill 发布到我的 GitHub，建一个公开 repo。

Claude 会替你跑 `gh repo create` 之类的命令，把你的 skill **push**（发布）上去，然后给你一个网址 —— 那就是你的 skill 在 GitHub 上的家。

## 别人怎么装你的 skill

你把网址发给一个朋友。他想用你的 skill，只要在他自己电脑上让 Claude：

> 把这个 repo clone 到我的 `~/.claude/skills/` 里：<你的网址>

**clone** 就是"拷一份下来"。拷完，这个 skill 就装进了他的 `~/.claude/skills/`，对他的 Claude 立刻可见 —— 跟你第 6 章手写的那个一样能触发。

分享这条路就通了：你存档、发布；别人 clone、就装好了。中间没有一步要你背 git 命令 —— 全是开口让 Claude 做。

## 小结

- **commit（存档点）**：把文件夹此刻的样子整个记下来，随时能退回。
- **diff**：看清两个存档点之间改了什么。
- **push / 发布**：把 skill 发到 GitHub。
- **clone / 拷一份**：别人把你的 skill 装进自己的 skills 目录。
- 一个 skill = 一个 repo。**别**给整个 `~/.claude/skills/` 存档。
- 这些你都不用亲手敲 —— 开口让 Claude 做。

## 下一章

[第 11 章 —— *下一步*](./11-next-steps.md)。这本书要教的到此为止；最后一章是一张"出口匝道"，告诉你每扇进阶的门后面是什么。
