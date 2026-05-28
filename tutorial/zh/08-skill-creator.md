# 第 8 章 —— 用 skill-creator

_上次校对：2026-05，对齐 Claude Code v2.x_

到这里你已经手写过 skill 两次了（单文件、然后多文件）。现在把工作流反过来：你用普通中文描述你想要什么，Claude 通过内置的 `/skill-creator` 替你写出 skill。接下来再处理最常见的后续问题 —— skill 不能稳定触发 —— 学怎么调它的 `description`。

这一章的例子故意跟"审稿 skill"不同。你会建一个 **PRD note 起草器** —— 把一堆乱糟糟的会议纪要、Slack 引文、bullet 点变成结构化的 PRD note。（这同一个 skill 会作为第 9 章的 PM 风味练习再次出现。）

## 用 /skill-creator

在任何文件夹打开 Claude —— 我们要建的是全局 skill，跟文件夹无关。

> 🛠 试一试
>
> 输入：`cd ~ && claude`
>
> 在 Claude 的 prompt 上输入：`/skill-creator`
>
> 你应该看到：Claude 回一段多行响应，介绍 skill-creator 的流程。它会问你想让 skill 做什么、谁触发、输入是什么样、输出该长什么样。

用你自己的话回答。不要在脑子里先把 `SKILL.md` 写好 —— 就描述这个 skill 该干什么：

> 🛠 试一试
>
> 类似这样回答：
>
> > 我想要一个 skill，把粗糙的会议纪要（段落、bullet、Slack 引文、各种乱糟糟混在一起的内容）变成结构化的 PRD note。输出包含这几节：问题、提议方案、待解决问题、已决定的下一步、风险。当我说"把这个变成 PRD"、"从这些里起草一个 PRD"、"从这些笔记抽出 PRD note"时触发。user 会把粗糙内容粘到 prompt 里、或者指向一个文件。
>
> 你应该看到：Claude 给出一个 `SKILL.md` 草案 —— frontmatter 有 name 和 description，body 里有节标题列表和触发逻辑。它会问要不要写文件。

批准。看看建出来的东西：

> 🛠 试一试
>
> 输入：`ls ~/.claude/skills/`
>
> 你应该看到：原来已有的 skill（比如 `review-writing`）加上一个新文件夹，名字是 `/skill-creator` 自己选的 —— 大概率类似 `prd-note-drafter`。
>
> 然后：`cat ~/.claude/skills/prd-note-drafter/SKILL.md`（具体文件夹名按实际为准）
>
> 你应该看到：一份完整的 `SKILL.md`，有 frontmatter、description、body 节标题、触发关键词 —— 跟第 6 章手写的那个一样的结构。

## 用真实输入试一下

测试它能跑。粘一段乱糟糟的文字让它重组：

> 🛠 试一试
>
> 在 Claude prompt 上粘一段混合文本，例如：
>
> > 把下面这个变成 PRD："从昨天会上听到：大家对新 dashboard 的过滤器侧栏很迷惑。Felix 说应该默认隐藏。工程组反对 —— 不想季度中改默认状态。Sarah 提议改成发新手引导覆盖层。待解决：A/B 测试还是直接发。Action：周五前出"默认隐藏"的设计稿。"
>
> 你应该看到：Claude 产出一份结构化 PRD note，含问题、提议方案、待解决问题、已决定的下一步、风险这几节 —— 内容是从粗糙文本里抽出来重写的。

skill 触发了（你说了"把这个变成 PRD"，description 里列了这个）。输出按你指定的形态走。换不同粗糙输入再试一两次，看效果稳不稳。

## 触发不到位的时候

一个常见 failure：某种说法能触发 skill、另一种说法不行。你说"把这个变成 PRD"，触发了。你说"帮我从这些做一个 PRD note"，没触发。两个**应该**都能用。**修法不是永远改你的说法 —— 而是改 description**。

skill-creator 给 skill 写了一个 description。看一眼它写的是什么：

> 🛠 试一试
>
> 输入：`head -10 ~/.claude/skills/prd-note-drafter/SKILL.md`（具体文件夹名按实际为准）
>
> 你应该看到：frontmatter 块，含 `description` 字段。仔细读一遍。注意：哪些触发说法它列了、哪些没列。

如果你想让触发更广，扩 description 里的触发措辞。下面是一个**改前/改后**的对比：

**改前**（窄）：

```yaml
description: |
  从粗糙的会议纪要起草结构化 PRD note。当 user 说"把这个变成 PRD"时触发。
```

**改后**（宽）：

```yaml
description: |
  从各种粗糙输入起草结构化 PRD note —— 会议纪要、Slack 引文、bullet 列表、
  各种乱糟糟的混合文本。输出节标题：问题、提议方案、待解决问题、
  已决定的下一步、风险。当 user 要求"把这个变成 PRD"、"起草一个 PRD"、
  "做一个 PRD note"、"从这些抽出 PRD"、"把这些笔记写成 PRD"或者
  任何相近变体时触发。如果 user 直接贴了一段粗糙的会议内容并要求结构化
  整理，也触发。
```

变了什么：更多同义词（起草、做、抽、写成）、更多输入描述（Slack 引文、bullet 列表）、一条 fallback 规则（"粗糙会议内容 + 要求结构化整理"）。body 一个字都没动 —— 只是把触发面拓宽了。

> 🛠 试一试
>
> 在编辑器里打开 `~/.claude/skills/prd-note-drafter/SKILL.md`，把它的 `description` 换成上面那个宽版本。
>
> 然后在一个新的 `claude` session 里，用一个**原版没接住**的说法再试一下，比如："帮我把这些东西做成 PRD note：[粘内容]"。
>
> 你应该看到：skill 触发了，产出按 PRD 形态的输出。

## 排错 checklist —— "我的 skill 没触发"

留着这个清单。skill 出问题的时候按顺序过：

1. **文件位置。** `SKILL.md` 在 `~/.claude/skills/<skill-name>/SKILL.md` 吗？大小写对吗？
2. **frontmatter 分隔线。** 是不是三个 dash（`---`）单独成行，YAML 块上下都有？
3. **必需字段。** frontmatter 是否同时有 `name` 和 `description`？
4. **新的 session。** 改了 skill 之后有没有开**新**的 `claude`？老 session 看不到更新。
5. **description 覆盖度。** 把你的 description 念一遍。**user 实际会打的那些说法**你写进去了吗？"当 X 时触发"只在 X 跟 user 真实说法对上时有用。
6. **触发的具体度。** 触发面太宽（跟别的 skill 重叠）跟触发不到一样糟。如果多个 skill 可能同时被触发，把每一个的 description 收窄到不重叠。

如果照这个清单走完一遍 skill 还是不触发，把 description 暴力简化（一句话、一个明确触发短语、不带任何修饰），确认能在那一句话上触发，然后再一步一步加宽回去。

## 小结

- `/skill-creator` 把"用普通中文描述"变成完整 `SKILL.md`。
- 它生成的 skill 是**你的** —— 像普通文件一样审、改。
- skill 不触发时，修的几乎永远是 `description`，body 不动。
- 排错清单留着，能盖住 90% 的不触发情况。

## 下一章

[第 9 章 —— *三个练习*](./09-exercises.md)。你会拿到三个 stretch 任务：一个设计师场景、一个 PM 场景、一个通用场景 —— `tutorial/skills/exercises/` 下有参考 `SKILL.md` 答案，想对比时去看。
