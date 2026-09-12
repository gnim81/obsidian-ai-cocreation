---
description: 分析人工修改模式，产出 voice-update 供合并进风格库
argument-hint: <项目名> <文件名>
---
目标：$ARGUMENTS

步骤：
1. diff `30-drafts/_baseline/<文件>` 与 `40-review/<文件>`。
2. 归纳修改模式：他删掉了什么（如花哨比喻）？加进了什么（如亲身观察）？句式与结构偏好？
3. 写成 `20-notes/voice-update-<今天日期>.md`，每条模式附 diff 证据（改动前后各一句）。
4. **禁止写入 `04-Resources/`**（voice-reference 由人工审定后合并）。
5. 汇报：3–5 条最显著的修改模式，一句话总结。
