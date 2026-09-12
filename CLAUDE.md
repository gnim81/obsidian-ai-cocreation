# Vault 宪法（AI 必读）

本 vault 采用 PARA 结构。任何 AI 会话开始前，先读本文件，再按路由表定位上下文，**不要盲扫全库**。

## 1. 目录地图与权限边界

```
00-System/       治理层：模板、Bases 视图          只读
01-Inbox/        唯一入口，不分类，定期清空         可写
02-Areas/        长期领域，永远"未完成"         只读
03-Projects/     在途创作主题（AI 共创区）          可写（受限，见下）
04-Resources/    跨项目参考资料                    只读
05-Archive/      归档                              只读
```

### 03-Projects/<主题>/ 内部权限

| 层 | 目录 | AI 权限 |
|---|---|---|
| 原料 | `10-source/` | **只读。禁止改写、禁止删除**（append-only，只允许人类追加） |
| 加工 | `20-notes/` | 可读写（摘要卡、论点、案例卡，末尾必须回链素材出处） |
| 共创 | `30-drafts/` | 可读写（新版本写新目录 v2/、v3/，永不覆盖旧版本） |
| 接管 | `40-review/` | 只读（人类正在修改的版本） |
| 定稿 | `50-final/` | **禁写** |
| 分发 | `60-published/` | 只读 |

## 2. 硬性规则

1. **先读 `_brief.md` 和 `challenges.md`**：进入 `03-Projects/<主题>/` 后，第一步永远读该项目的 `_brief.md`（目标/受众/风格/必含与禁止/验收标准/当前进展），以其为准，不要重新发挥；若项目有 `challenges.md`（反方最强论据），行文中必须正面回应，不得回避或顺着简报强化回音室。
2. **`10-source/` 只许引用、摘录、结构化、建链接**，不得改写原文件。摘录一律用 `>` 引用块保留原文，批注写在下方。
3. **AI 初稿必须双写**：在 `30-drafts/vN/` 写正式稿的同时，存一份 untouched 副本到 `30-drafts/_baseline/`（文件名一致），供人工 diff 审计。
4. **`human_locked: true` 的文件**只允许提议修改（propose edit），不得直接写入。
5. **不编造**：数据、案例、引用必须有 `10-source/` 或外部 URL 依据；简报"Must avoid"里的词禁用。
6. **AI 参与度标注**：每次产出在 frontmatter 写 `authored_by`（human | ai-assisted | ai-generated）、`ai_level`（none/hint/assist/pair/copilot/auto）、`ai_model`。
7. **状态机**：idea → outline → drafting → revising → review → final → published → archived。更新文件时同步更新 frontmatter 的 `status` 和 `updated`。
8. **命名**：文件名一律小写连字符（`career-plan.md`）；素材文件带日期前缀（`2026-08-11-访谈A.md`）。
9. **跨领域主题不复制**：物理上只放 `03-Projects/`，用 frontmatter `area: [...]` 做软关联。
10. **隐私**：访谈对象、未公开数据、他人稿件不进云端模型上下文；上下文文档只描述结构与方法。

## 3. 领域路由表

| 领域 | 上下文文件 | 触发关键词 |
|---|---|---|
<!--area-rows-start-->
| 副业实践 | [[02-Areas/副业实践/_context]] | 副业、变现、选题、课程 |
| 投资理财 | [[02-Areas/投资理财/_context]] | 持仓、估值、复利 |
| 研发技术 | [[02-Areas/研发技术/_context]] | 架构、性能、代码 |
| 学习教育 | [[02-Areas/学习教育/_context]] | 课程、读书、方法 |
| 健康 | [[02-Areas/健康/_context]] | 睡眠、训练、饮食 |
<!--area-rows-end-->

## 4. 日常工作流

- **开题**：`03-Projects/` 建目录（用 [[00-System/templates/tpl-project-brief]] 初始化 `_brief.md`）→ 在 [[_INDEX]] 挂链接。
- **攒素材**：剪藏/访谈/灵感进 `10-source/`（对应 clippings/ interviews/ sparks/），带时间戳与 `source:` URL。
- **收藏与沉淀**：跨项目第三方文章进 `04-Resources/clippings/`（`/intake/clip` 暂存、人工移入）；领域判断进 `02-Areas/`（`/knowledge/note` 暂存+待粘贴，修正记 changelog 不覆盖，机制见使用指南 §4.12）。
- **加工**：读 `10-source/` 产出摘要卡到 `20-notes/`，每份末尾回链素材。
- **共创**：读 `_brief.md` + `challenges.md` → `30-drafts/vN/` 出稿 + `_baseline/` 存底 → 人工大幅修改后，让 AI 分析修改模式，把分析写到当前项目 `20-notes/voice-update-<日期>.md`，由人工审定后合并进 `04-Resources/voice-reference.md`（AI 对 `04-Resources/` 只读，不直接回写）。
- **定稿**：`50-final/`（`human_locked: true`）→ 副本进 `60-published/` → 在 `journal.md` 记录卡点 → 项目完结整体移入 `05-Archive/YYYY/`。

## 5. 配置索引

- 权限拦截：`.claude/settings.json`（deny → ask → allow，deny 优先）
- MCP 边界：`.mcp.json`（vault-read 全库只读 / project-rw 钉在 03-Projects）；Linux/macOS 机器上用 `.mcp.linux.json` 覆盖它（改路径后重命名）
- 斜杠命令：`.claude/commands/` 按功能分五组——`/intake/`（collect 收集、clip 收藏文章、triage 周清）；`/produce/`（new 开项目、digest 加工、draft 出稿、iterate 迭代、brief 进展快照、archive 归档）；`/knowledge/`（note 领域判断写/改）；`/quality/`（factcheck 事实溯源、voice 风格分析）；`/query/`（search 检索、status 总览）。命令地图见使用指南 §5.5
- 确定性脚本：`00-System/scripts/`（status.sh 状态统计、new-project.sh 项目脚手架、archive-project.sh 归档移动）——建目录/移动/统计/翻状态这类无需语义判断的操作一律让脚本执行（零幻觉、零 token、可脱离会话运行），AI 只做其中的判断性环节
- Obsidian 治理：`.obsidian-agentignore`、`.obsidian-agentprotected`（改不了自己的枷锁，勿动；仅约束经 Obsidian 的 AI 写入，外部直写靠 MCP 与 deny 规则）
- 看板视图：`00-System/bases/共创看板.base`、`00-System/bases/待我接管.base`、`00-System/bases/AI参与度审计.base`（`.base` 不是笔记，用路径打开而非 wikilink）
- 模板：`00-System/templates/`
