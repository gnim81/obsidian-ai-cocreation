---
description: 对比人工修改版与基线，按修改意图写下一个版本（不动旧版）
argument-hint: <项目名> <文件名>
---
目标：$ARGUMENTS

步骤：
1. diff `30-drafts/_baseline/<文件>` 与 `40-review/<文件>`，先归纳人工修改体现了什么意图（结构？语气？删冗余？）。
2. 基于该意图写新版本到 `30-drafts/v<下一版本号>/`，同样双写 `_baseline/` untouched 副本。
3. 旧版本目录（v1、v2…）和 `40-review/` 一律不动。
4. 新版本 frontmatter：status: revising（AI 已按人工意图改完，等人工再审）、based_on 指向上一版。
5. 汇报：从 diff 里读出的修改模式清单，以及你据此做了哪些改动。
