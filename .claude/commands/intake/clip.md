---
description: 收藏第三方文章：抓取/读取原文暂存 Inbox，待人工移入 04-Resources/clippings/
argument-hint: <URL 或本地文件路径 或粘贴的全文> [所属领域]
---
目标：$ARGUMENTS

设计前提：`04-Resources/clippings/` 是第三方原文层（AI 只读）。本命令在 Inbox 暂存，移动由人工完成。

步骤：
1. 获取内容：URL → 抓取全文（尽量含作者/日期）；本地文件 → 原样读取；直接粘贴 → 用粘贴内容。
2. 写暂存文件 `01-Inbox/<今天日期>-clip-<小写连字符短标识>.md`：
   - frontmatter：type: source、source: <URL/文件路径>、captured: 今天、area: [<领域>]（按 CLAUDE.md 路由表推测，标注请确认）、tags: [来源/剪藏]
   - 正文：原文**完整保留**（不改写、不删节、不总结），顶部加"收藏规则" callout（同 tpl-source 约定）
3. 原文超长（>1 万字）时降级：只暂存 frontmatter + 300 字摘要 + 原文链接，提醒我全文自行存档后把路径补进 source。
4. 提醒我两件事：
   a) 在 Obsidian 里把暂存文件拖进 `04-Resources/clippings/`（双链自动跟随）；
   b) 读完想沉淀判断时跑 `/knowledge/note <领域> <我的判断>`——判断去 Areas，不要写在原文上。
5. 汇报：暂存路径 + 推测的领域 + 一句话内容概括（方便我决定读不读）。

边界：不写 `04-Resources/`（AI 只读）；不得用 bash 移动文件；涉及访谈对象、未公开数据、他人稿件的内容提醒我不要经云端模型处理。
