---
description: 更新项目简报进展快照：§9 当前进展 + status，从稿件状态与 journal 自动汇总
argument-hint: <项目名>
---
目标：$ARGUMENTS

步骤：
1. 读 `03-Projects/<项目>/` 的：`_brief.md`、`journal.md` 最近 3 条、`30-drafts/` 各稿 frontmatter（status/version/updated）、`40-review/` 与 `50-final/` 的文件名。
2. 汇总成 §9 当前进展新文本：已完成：…；进行中（卡点）：…；下一步：…。**证据只来自稿件状态与 journal，不编造**；journal 里的"卡点"原样带入。
3. 更新 `_brief.md`：替换 §9、同步 frontmatter 的 `status` 与 `updated`。
4. **只动这两处**。§1–8、§10–11 是人工策展的战略内容（目标/受众/风格/验收），不得修改；若发现它们与现状明显脱节，单独列出修改建议等我确认。
5. 汇报：改动 diff 摘要 + 发现的脱节点。
