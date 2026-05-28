# 第 2 章 —— 装好你的工具箱

_上次校对：2026-05，对齐 Claude Code v2.x_

读完这一章，你的 Mac 上会装好 Claude Code、登好录，准备开干。涉及四件事，按顺序来：**Homebrew**、**Node.js**、**Claude Code**、**Anthropic 登录**。每一件都是一行命令（或者接近一行）。章末有一个小侧栏，对比三种付费方式。

如果第 1 章你读得舒服，这一章也会舒服 —— 你还是用那五个命令导航，只是中间多了几个新工具去装。

## 开始之前说一句

下面四条命令里，有三条要你把一个 URL 粘进 Terminal。**粘之前先把那一行看一眼**再回车。一台 Mac 平时用根本不需要这种操作（应用都从 App Store 来），但装开发工具这件事，"从网站上拷一条命令"确实是行业标准做法。本章里出现的网站都是第一方（brew.sh、anthropic.com），可以信。

## 1. 装 Homebrew

Homebrew 是一个 **包管理器** —— 一种"帮你装其他软件"的软件。在 macOS 上，它是装"给开发者用的程序"的标准工具。Homebrew 装一次就够了；这之后，本章剩下的所有工具都只是一行 Homebrew 命令的事。

安装命令在 brew.sh 上。打开 Terminal.app，把下面这条粘进去：

> 🛠 试一试
>
> 输入（或粘贴）：`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
>
> 回车。它会问你 Mac 的密码 —— 直接打（你打的时候光标不显示，这是正常的）然后回车。
>
> 你应该看到：一长串的 "Downloading..."、"Installing..."，最后是 `Installation successful!` 这一行。临近结束时，可能会打印 "Next steps"，附两行关于添加 Homebrew 到 PATH 的命令 —— 如果出现了，把那两行也复制粘贴运行一下。

确认 Homebrew 装好了：

> 🛠 试一试
>
> 输入：`brew --version`
>
> 你应该看到：`Homebrew 4.x.x`（任何以 4 开头的版本号都行）。

如果没看到，关掉 Terminal.app 重新打开再试一遍 —— 安装脚本有时候要重开终端才生效。

## 2. 装 Node.js

Claude Code 通过 **npm**（Node Package Manager）发布，npm 跟 **Node.js** 一起来。所以装 Claude Code 之前要先有 Node.js。一行 Homebrew 搞定。

> 🛠 试一试
>
> 输入：`brew install node`
>
> 你应该看到：Homebrew 在下载、安装 Node.js，最后一行 `==>` 开头的说装完了。整个过程视你的网速一两分钟。

验证：

> 🛠 试一试
>
> 输入：`node --version`
>
> 你应该看到：类似 `v22.x.x` 的版本号（任何 18 及以上的版本对 Claude Code 都够用）。
>
> 然后输入：`npm --version`
>
> 你应该看到：类似 `10.x.x` 的版本号。

## 3. 装 Claude Code

再一行：

> 🛠 试一试
>
> 输入：`npm install -g @anthropic-ai/claude-code`
>
> 你应该看到：npm 下载一串 package，最后一行类似 `added NN packages in Ns`。

`-g` 这个 flag 是 "全局安装" 的意思 —— `claude` 就变成了你在任何文件夹里都能敲的命令，不局限于某一个项目。

验证：

> 🛠 试一试
>
> 输入：`claude --version`
>
> 你应该看到：类似 `2.x.x (Claude Code)` 的输出。

## 4. 登录 Anthropic

Claude Code 要跟 Anthropic 的服务器对话才能干事。它得知道哪个 Anthropic 账号是你的，把账记到对的地方。

这一步**不是** 🛠 框，因为它会打开浏览器窗口 —— 验证方式是"浏览器显示登录成功"，不是"终端打出某一行特定文字"。

在任意文件夹里输入 `claude`（就这一个词，不带参数），回车。第一次跑会：

1. 在终端打印一段简短的引导信息
2. 在默认浏览器里打开 Anthropic 的登录页
3. 让你登录（或者注册） —— 用你想绑定账单的那个邮箱
4. 登录之后跳到"可以关闭这个标签了"的页面
5. 终端里也会打印一条"已登录"的确认信息

如果你还没有 Anthropic 账号，登录页面就能注册。注册时**选 Claude Pro 套餐** —— 那是本书默认的路径（其他选项见下面的侧栏）。

终端里看到登录确认之后，按 `Ctrl+C` 退出 `claude`。真正的第一次对话在第 3 章。

## 侧栏 —— 付费选项

本书推荐 **Claude Pro**。另外两种是给特定场景准备的，读这本书不需要。

| 套餐 | 月费（约，2026-05） | 适合谁 | 配置复杂度 |
|---|---|---|---|
| **Claude Pro** *（本书默认）* | US$20 | 大多数读者，包括所有跟着这本书走的人 | 一次浏览器登录 |
| **Claude Max** | US$100–200（看档位） | 每天重度使用、跑长 agentic 任务的人 | 跟 Pro 一样，只是更高档 |
| **API pay-as-you-go** | 按 token 计费 | 已经有 API 工作流、或者想把 Claude Code 写进脚本里的开发者 | console.anthropic.com 拿一个 API key + 设环境变量 `ANTHROPIC_API_KEY` |

本书所有内容 —— 每一章、每一个 🛠 框、每一个 skill —— 在 Claude Pro 上都能跑。以后想升级也很顺。

## 小结

- `brew install …` 装开发工具
- `npm install -g @anthropic-ai/claude-code` 装 Claude Code
- `claude` 启动它（第一次会让你登录）

## 下一章

第 3 章 —— *你的第一次对话*。你会建一个空文件夹、`cd` 进去、跑 `claude`，然后进行真正的第一次对话 —— Claude 读你写的一个文件、Claude 帮你写一个新文件、Claude 跑一条命令。
