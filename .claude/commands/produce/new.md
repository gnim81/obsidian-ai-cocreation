---
description: 新建创作项目：脚本脚手架 + AI 填简报 + 待粘贴索引行
argument-hint: <项目名> [mini] [一句话描述]
---
目标：$ARGUMENTS（项目名必填；单篇小项目加 mini；可附一句话描述供填简报）

分工：目录骨架与三个骨架文件由确定性脚本完成（零幻觉）；你只做判断性环节。

步骤：
1. 确认 `03-Projects/<项目名>/` 不存在；已存在则停下问我，不得覆盖。
2. 执行脚本：`bash 00-System/scripts/new-project.sh <项目名> [mini]`
   （脚本建空目录——`10-source/` 等禁写区不会有任何占位文件；生成 `_brief/challenges/journal` 骨架；输出两段待粘贴行。）
3. 按参数里的一句话描述填充 `_brief.md` 能确定的部分（领域倾向按 CLAUDE.md 路由表推测并标注请确认）；拿不准的留占位符，不要编造。
4. 核对脚本输出的待粘贴内容（`_INDEX.md` 表格行 + 相关领域 `_context.md` 双链行），领域推测有误先修正再给出。
5. **禁止修改 `_INDEX.md` 和 `02-Areas/*/_context.md`（AI 禁写区）**，粘贴由我手工完成。
6. 提醒我：填完 `_brief.md` 的 §1/§3/§6/§10 再开始 `/produce/draft`；`challenges.md` 至少写 2 条反方论据；（可选）给 `_brief.md` 加书签。
7. 汇报最终目录树。
