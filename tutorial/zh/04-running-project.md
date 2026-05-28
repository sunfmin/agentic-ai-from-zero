# 第 4 章 —— 让 Claude 认识你的项目

_上次校对：2026-05，对齐 Claude Code v2.x_

到现在你都在临时文件夹里玩。该挪进一个会陪你读完后面所有章节的真实项目里了 —— 顺便让 Claude 也认识它。

这个项目故意做得小：一个文件夹，里面是几篇等着改的写作草稿。第 6、7、8 章你都会回到它上面。后面每一个 skill 都会跑在这些草稿上。

## 把主项目建起来

我们附带了一个 starter 文件夹，里面已经有三篇草稿了 —— 是故意写得不好的，让你第 6 章建出来的"审稿 skill"有真东西可批。

> 🛠 试一试
>
> 输入：`cd ~ && mkdir -p writing && cd writing`
>
> 然后把 starter 里的草稿复制进来。在 Finder 里打开教程仓库（如果还没 clone，从 GitHub 下个 zip），找到 `tutorial/zh/starter/writing/`，把那三个 `.md` 文件拖进你的 `~/writing` 里。
>
> 或者你 clone 过仓库的话：`cp /path/to/agentic-ai-from-zero/tutorial/zh/starter/writing/*.md .`
>
> 然后验证：`ls`
>
> 你应该看到：`announcement.md`、`launch-post.md`、`standup-summary.md`。

任意挑一个用你熟悉的编辑器打开（或者 `open announcement.md` 让 macOS 自己选）。读一段。注意一下它读起来是什么感觉 —— 啰嗦、被动、抽象。你未来要建的那个 skill 就是专门治这个的。

## 在项目里启动 Claude

> 🛠 试一试
>
> 确认你在 `~/writing` 里：`pwd`
>
> 你应该看到：`/Users/yourname/writing`。
>
> 然后：`claude`
>
> 你应该看到：Claude 的欢迎、然后是 prompt。

`~/writing` 现在是 Claude 的工作目录。这次 session 里的所有事都相对它发生。

## 跟 Claude 一起写一个 CLAUDE.md

`CLAUDE.md` 是 Claude Code 在这个文件夹下每次启动 session 都会读的一个特殊文件。它的作用是：把"**这个**项目是什么"教给 Claude —— 那些每次回到项目都成立的上下文，不必每次重新解释。

不要从模板填空写。用对话方式写。打字的活儿主要让 Claude 干。

> 🛠 试一试
>
> 在 Claude 的 prompt 上：
>
> > 读一下这个文件夹里这三篇草稿。然后给我提一个 `CLAUDE.md` 草案，5 到 10 行讲清楚这个项目是什么 —— 一个我在改的写作草稿文件夹。把你在草稿里看到的问题类型（啰嗦、被动语态、抽象名词）列一下，建议任何"审稿用的 skill"都聚焦在这些点上。
>
> 你应该看到：Claude 读完三个文件，总结一下问题，给出 `CLAUDE.md` 草案，请求写入。
>
> 批准写入。然后 `cat CLAUDE.md`（另开终端、或者 `/exit` 之后再敲）看看落到硬盘上的是什么。

你刚拿到的这个 `CLAUDE.md` 是**你的**。随时改它，加东西、删东西都行。以后哪一天你看不懂 Claude 为什么要这么建议某件事，先看 `CLAUDE.md` —— 它是优先级最高的上下文。

## CLAUDE.md 凭什么比"多 prompt 一次"更重要

你完全可以每次 session 开头都打："这是一个写作草稿文件夹，重点看啰嗦……" —— 但你会每次都打一遍，而且每次打得都不太一样。`CLAUDE.md` 把重复解释这件事终结了。你用你自己的话说一次，Claude 在这个文件夹下每次启动都会读到它。

`CLAUDE.md` 是最轻量的"定制"。再往上一档 —— 从第 5 章开始 —— 就是 **skill**。

## 小结

- `CLAUDE.md` 在项目文件夹里；Claude 每次在这个文件夹下启动 session 都会读它。
- 它跟项目绑定，由你（或者你跟 Claude 一起）写，跨 session 保留。
- 它是一份契约："关于这个项目，下面这些事每次都成立。"

## 下一章

第 5 章 —— *什么是 skill*。`CLAUDE.md` 是一种定制方式；**skill** 是另一种。你会搞清楚它们有什么不同，以及为什么两个都值得有。
