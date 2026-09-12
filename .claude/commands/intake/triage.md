---
description: Inbox 周清：逐条分析去向，生成执行计划（移动/删除由人工执行）
argument-hint: [过滤条件，留空=全部]
---
目标：$ARGUMENTS（留空 = Inbox 全部条目）

步骤：
1. 列出 `01-Inbox/` 全部条目（README.md 除外）。
2. 逐条判断去向，三选一：
   a) **当前项目素材** → 目标 `03-Projects/<项目>/10-source/{clippings,interviews,sparks}/`（项目按各 `_brief.md` 的 status: active 判断）；
   b) **领域相关** → 原文类去 `04-Resources/clippings/`（/intake/clip 同款去处）；判断类去 `02-Areas/<领域>/`（可接着跑 /knowledge/note 出提炼版）；
   c) **无价值** → 建议删除。
3. 输出执行计划表：条目 | 建议去向 | 一句话理由 | 可接续的命令。
4. 经我确认后，先做你权限内的部分：在 `01-Inbox/` 内为去向 a) 的条目补 tpl-source 式 frontmatter（改名也行）；**移动与删除列成清单等我手工执行**（10-source/04-Resources/02-Areas 都是 AI 禁写区，删除的 rm 也是 deny——这些必须人工）。
5. 汇报：处理后 Inbox 剩余条目数 + 待我执行的清单。
