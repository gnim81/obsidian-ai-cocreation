---
description: 全库只读检索知识（走路由表，不盲扫）
argument-hint: <检索主题>
---
目标：$ARGUMENTS

步骤：
1. 先查 `CLAUDE.md` 的领域路由表，命中哪个领域先读 `02-Areas/<领域>/_context.md`。
2. 再按关键词深入该领域与 `04-Resources/` 检索，顺双链扩展。
3. 汇总回答，每条结论附文件路径出处。
4. 只读：不修改、不新建任何文件。
