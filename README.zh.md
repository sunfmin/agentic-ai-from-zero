# Agentic AI from Zero

> 🌐 **English version**: [`README.md`](./README.md)

一个双语（中文 + 英文）教程仓库，把一个完全零基础的命令行初学者从"我从没打开过终端"带到"我会写多文件 Claude Code skill"。

仓库里包含：

- **教程本体** —— 在 [`tutorial/`](./tutorial/README.md) 下，`zh/` 和 `en/` 是互为镜像的目录
- **示例 skill 制品** —— `tutorial/skills/` 下教程引用的可安装制品
- **决策文档** —— [`CONTEXT.md`](./CONTEXT.md)（术语字典 + 读者画像）和 [`docs/adr/`](./docs/adr/)（架构决策）
- **Bootstrap 案例研究** —— 这个仓库本身是怎么在一次 Claude Code session 里从零搭起来的：[`BOOTSTRAP-CASE-STUDY.md`](./BOOTSTRAP-CASE-STUDY.md)（中文）和 [`BOOTSTRAP-CASE-STUDY.en.md`](./BOOTSTRAP-CASE-STUDY.en.md)（English）

## 范围速览

- **macOS only** —— 见 [ADR-0001](./docs/adr/0001-tutorial-scope.md)
- **双语**（中文 + 英文）—— 互为镜像的目录
- **版本策略**：不锁全局 Claude Code 版本；每章自己有校对时间戳。见 [ADR-0002](./docs/adr/0002-versioning-policy.md) 和 [`STATUS.md`](./STATUS.md)。

## 开始读

→ [`tutorial/README.md`](./tutorial/README.md) —— 语言选择页

## 维护者向

- [`STATUS.md`](./STATUS.md) —— 每章校对状态仪表盘
- [`scripts/lint-chapters.sh`](./scripts/lint-chapters.sh) —— 提交章节改动前先跑一遍
- [`CONTEXT.md`](./CONTEXT.md) —— 术语表（哪些翻译、哪些保留英文）
- [`docs/`](./docs/) —— ADR 和 agent 配置
