# 第 7 章 —— 多文件 skill（渐进式展开）

_上次校对：2026-05，对齐 Claude Code v2.x_

第 6 章你写的那个 skill 能跑。body 几百字。目前可以。

但是想象一下这个 skill 长大了。再加三条原则，每条加两三个例子，再加输出格式规范，再加一份你专门想禁用的词组列表。突然 `SKILL.md` 变成了两千字。每次 skill 触发，Claude 都得读完那两千字。对一次快速审稿来说，开销大 —— 更糟的是，真正相关的指令被埋在体量里。

**渐进式展开**（progressive disclosure）就是治这个的 pattern。把 skill 拆到多个文件里。`SKILL.md` 保持短小、以"指路"为主；把厚重的参考材料放进同级的兄弟文件。`SKILL.md` 说："当这种审稿被请求时，**也要去读 principles.md**" —— Claude 真的就去读，但只在那一刻真正需要原则清单时才读。

这一章你会把第 6 章那个 skill 重构成多文件版本。**不加任何新内容** —— 同样四条原则、同样的输出格式、同样的触发措辞。**只有文件形态变了**。这正是关键：去感受形态差异，而不是内容差异。

## 把 v2 跟 v1 放一起看

我们在仓库里同时附带了两个版本，都在 `tutorial/skills/` 下：

> 🛠 试一试
>
> 输入：`ls tutorial/skills/review-writing-v1/`
>
> 你应该看到：`SKILL.md`、`fixture-draft.md`。
>
> 然后：`ls tutorial/skills/review-writing-v2/`
>
> 你应该看到：`SKILL.md`、`principles.md`、`fixture-draft.md`。

同一个 skill —— 两份。v1 的 `SKILL.md` 是 42 行。v2 的 `SKILL.md` 是大约 25 行，加一行链接指向 `principles.md` 承担那部分厚重参考内容。

把两个 `SKILL.md` 对比一下：

> 🛠 试一试
>
> 输入：`diff tutorial/skills/review-writing-v1/SKILL.md tutorial/skills/review-writing-v2/SKILL.md`
>
> 你应该看到：v2 的 body 用一条指向 `principles.md` 的引用代替了原则定义本身。frontmatter（`name`、`description`）完全相同 —— 触发行为在 v1 和 v2 之间不允许变。

## 渐进式展开的形态

v2 的 `SKILL.md` body 现在长这样：

```markdown
# 审阅写作

当 user 要求审稿时：

1. 读 user 指的那个文件。如果他们没说哪个，问一下。
2. 读 [principles.md](./principles.md)，了解四条原则（P1..P4）以及怎么识别它们。
3. 用原则检查草稿。每发现一个问题 ……
4. 最后给一句整体评价 ……
```

第 2 步是新的形态。它告诉 Claude："真正的规则在一个同级文件里；需要时去读那个文件。"Claude 只在 skill **触发之后**才会顺着这个链接读 —— 不会预读、不会因为 skill 存在就读。

`principles.md` 本身就是普通 Markdown，里面是四条原则，每条配一两个改前/改后的例子。没有特殊语法。只是从 `SKILL.md` 里挪出来的内容。

## 为什么多出一个文件值

按重要性排序，三个理由。

**1. description 的活儿保持干净。** Claude 每次你打 prompt 都要扫硬盘上**每一个** skill 的 `description` 字段。body 只在触发后才被读。`SKILL.md` 短，意味着 description 待在一个更轻的文件里 —— 加载更快、触发措辞周围的噪音更少。对单个小 skill 来说这点没什么；当你 `~/.claude/skills/` 下有 50 个 skill 时差异就累计起来了。

**2. skill 保持可读。** 200 行的 `SKILL.md` 难以扫读。25 行的 `SKILL.md` 链接到几个聚焦的兄弟文件，让你能很快定位："这个 skill 干嘛？它还会读哪些文件？"结构本身就告诉你了。

**3. 各部分能独立修改。** 想加一条新原则？改 `principles.md`，不动 `SKILL.md`。触发逻辑和原则清单变化的**原因不同、时机不同、动手的人可能不同**。把它们拆开，让两者能各自独立演化，互不打扰。

## 装上 v2，确认行为一致

把第 6 章写在 `~/.claude/skills/review-writing/SKILL.md` 的内容换成 v2 版本，把新的 `principles.md` 拷到旁边。

> 🛠 试一试
>
> 输入：`cp tutorial/skills/review-writing-v2/SKILL.md ~/.claude/skills/review-writing/SKILL.md`
>
> 然后：`cp tutorial/skills/review-writing-v2/principles.md ~/.claude/skills/review-writing/principles.md`
>
> 然后：`ls ~/.claude/skills/review-writing/`
>
> 你应该看到：`SKILL.md` 和 `principles.md`。

像第 6 章那样触发 skill：

> 🛠 试一试
>
> 输入：`cd ~/writing && claude`
>
> 在 Claude prompt 上：
>
> > 帮我审一下 `announcement.md`。
>
> 你应该看到：一份带同样四个原则编号（P1..P4）的审稿，结尾同样有"整体"那一行。**输出**跟 v1 一致就说明重构对了。如果看到任何不同 —— 编号缺失、编号名字变了、整体那一行没了 —— 哪里出问题了；回滚到 v1（`cp tutorial/skills/review-writing-v1/SKILL.md ~/.claude/skills/review-writing/SKILL.md && rm ~/.claude/skills/review-writing/principles.md`）然后对比。

## 什么时候**不**用渐进式展开

下面这些情况，单文件 `SKILL.md` 是更合适的答案：

- 整个 skill 自然就能压在 50 行内、没什么长参考材料
- skill 只做一件聚焦的事、没有按上下文分支
- 你还在迭代这个 skill 该干什么 —— 过早拆分会把错的结构固化下来

不要在没尝过"不重构"的难受之前就重构。v1 不丢人。v2 是你长大后的样子。

## 小结

- 渐进式展开 = `SKILL.md` 小、用指针指向兄弟文件；兄弟文件只在 skill 触发后才被读。
- v1 → v2 是重构：触发相同、输出相同，只是文件形态变了。
- 收益在于**清晰度和可修改性**，不是性能本身。

## 下一章

[第 8 章 —— *用 skill-creator*](./08-skill-creator.md)。这次不再手写 `SKILL.md`，而是用普通中文描述你想要的 skill，看着 `/skill-creator` 把整套文件结构帮你生出来。你也会学到 description 不能稳定触发时怎么调它。
