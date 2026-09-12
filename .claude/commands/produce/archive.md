---
description: 归档已完成项目（软删除）：脚本移入 05-Archive，AI 提炼结论回写内容
argument-hint: <项目名>
---
目标：$ARGUMENTS

分工：机械部分（status 翻转、目录移动）由确定性脚本完成；你负责前置确认与结论提炼。

前置检查（有问题先停下问我，不要猜）：
1. `03-Projects/<项目>/` 存在；`_brief.md` §9 当前进展已收尾。
2. `50-final/` 有定稿、`journal.md` 末条有复盘——缺了先提醒我补。

步骤：
1. 经我确认后执行：`bash 00-System/scripts/archive-project.sh <项目名> -y`
   （脚本完成：status→archived、updated 刷新、移入 `05-Archive/<年>/`；含未提交文件时自动退回普通 mv。）
2. **禁止修改 `_INDEX.md` 和 `02-Areas/*/_context.md`（AI 禁写区）**。改为输出待粘贴内容：
   a) 提醒我删除 `_INDEX.md`「进行中的创作主题」中该项目的行；
   b) 从 `journal.md` 复盘提炼 2–3 条长期结论（每条附出处），标注"请人工审定后粘贴"进相关领域 `_context.md`。
3. 提醒我：结论回写 Areas 是归档的核心价值（飞轮），别跳过；随后手动 commit：`git add -A && git commit -m "archive: <项目名>"`。Obsidian 会自动跟随移动更新双链。
4. 汇报：移动前后路径、提炼出的结论清单。

注意：本命令是本库唯一的"删"——**软删（归档）**。真正的硬删除（rm）对 AI 是 deny 的，由人工执行。
