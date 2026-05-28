# 第 5 章 —— 什么是 skill

_上次校对：2026-05，对齐 Claude Code v2.x_

这一章三个短概念。合在一起回答"skill 是什么？"，但还不需要你动手写。写 skill 是第 6 章的事。

## 1. skill 不是 prompt

你在第 3 章打的"读一下 `notes.md`，把里面的内容告诉我" —— 那是 prompt。你打了，Claude 做了。下次 session，那个 prompt 就没了。

**skill** 是硬盘上的一个**文件**，Claude 在它被设计用于的场景出现时**自动读取**。你不用打它。你写一次就忘掉它；Claude 记得在合适的时候帮你用。

心态的转变是：从"我下次还要再说一遍"，到"我把这件事写成了一个'什么时候相关就发生'的东西"。skill 不是更快的 prompt。它是会**自己触发**的 prompt。

跟上一章对比一下：

| `CLAUDE.md` | skill |
|---|---|
| 属于**单个项目** | 属于**全局 skills 目录**（也可以属于单个项目，但全局是常态） |
| 在那个项目里**每次 session 启动都读** | **只在它的 description 匹配当前上下文时才读** |
| 项目专属上下文 | 可复用的 pattern，跨项目触发 |

`CLAUDE.md` 说的是"关于这个项目，永远成立的那些事"。skill 说的是"任何地方，当某个特定情境出现时，做某件事"。

## 2. skill 的最小形态

一个 skill 住在一个以它命名的文件夹里。这个文件夹里至少有一个文件：`SKILL.md`。下面是一个带注释的最小可用 skill（不需要敲，只是读）：

```markdown
---
name: review-writing
description: |
  审阅 user 个人写作项目里的草稿，检查啰嗦、被动语态、抽象表达。
  当 user 要求 "审阅"、"改" 或 "批评" 一篇草稿、或者贴出一个想要
  反馈的 markdown 文件时触发。
---

# 审阅写作

当 user 要求审稿时，按以下步骤：

1. 读他们指的文件。
2. 检查：啰嗦、被动语态、抽象名词替代具体动词。
3. 每个问题：引出原句，提出一个更紧凑的改写建议。
4. 最后给一句整体评价。
```

两个东西在做所有的活儿。

**顶部的 frontmatter 块**（两个 `---` 之间的部分）声明 skill 的 `name` 和 `description`。`description` 是**整个文件里最重要的字段** —— Claude 读它来判断这个 skill 是否跟**你刚才说的**有关。description 写错，skill 永远不触发；写对，它就在你想要它出现的时候出现。

**body**（第二个 `---` 之后的所有内容）是 skill 被**触发之后** Claude 才读的部分。是指令、步骤、规则，纯 Markdown。

这就是最小形态。真正的 skill 可以在 `SKILL.md` 旁边带很多别的文件（第 7 章会看到），但单文件 `SKILL.md` 已经是一个完整的 skill 了。

## 3. 触发是怎么发生的

每次你给 Claude Code 发 prompt，回复之前有两件事并行发生：

1. Claude 读当前项目的 `CLAUDE.md`（如果有的话）。
2. Claude 扫一遍所有可用 skill 的 `description` 字段，问自己："这里面有哪个跟 user 刚说的事有关系吗？"

如果有一个或多个匹配，Claude 把它们的 body 完整读进来，把指令揉进自己的回复里。如果没有匹配，Claude 就当没这个 skill 一样正常回复。

整个过程是自动的。你不需要说一个魔法词，不需要按名字指名 skill。你正常说你想要什么 —— 如果某个 skill 的 description 覆盖了这个场景，它就会被点起来。

正因为这样，**把 description 写好**比把 body 写好更重要。body 是 skill 被点起来**之后** Claude 才会看的。description 决定它**到底点不点得起来**。第 8 章专门讲怎么调 description。

> 🛠 试一试（反思型 —— 这一章不让你写 skill）
>
> 看一下 `~/.claude/skills/` 里有什么（`ls ~/.claude/skills/` 或者 `open ~/.claude/skills/`）。
>
> 你应该看到：一串文件夹，每一个都是你机器上已经装好的一个 skill —— 可能来自 Matt Pocock 的那一套、可能是 Anthropic 自带的、也可能你 `~/.claude` 是空的什么都没有。

随便打开一个，读它的 `SKILL.md`。看 frontmatter。光看 description，预测一下这个 skill 会在什么时候触发。然后再看 body，验证一下你的预测是不是跟 body 里描述的动作对得上。

## 小结

- skill 是自动触发的文件；prompt 是你打一次就没了的文字。
- skill 最少要有一个 `SKILL.md`，里面有 frontmatter（`name`、`description`）和 body。
- `description` 就是触发器 —— 它决定 Claude 到底会不会读 body。

## 下一章

[第 6 章 —— *写你的第一个 skill*](./06-first-skill.md)。你会把上面那个 `SKILL.md`（几乎原样地）写出来、装好，然后看着它在你的主项目的草稿上被触发。
