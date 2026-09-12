---
description: 按 _brief.md + challenges.md 共创初稿，双写 _baseline 存底
argument-hint: <项目名> <稿子标识，如：第3节>
---
目标：$ARGUMENTS

步骤：
1. 读 `03-Projects/<项目>/_brief.md` 与 `challenges.md`。若没有 `_brief.md`，停下来提醒我先建简报，不要自行发挥。
2. 读 `20-notes/` 下相关笔记卡，只使用可溯源到 `10-source/` 的事实。
3. 初稿写到 `30-drafts/v<下一版本号>/`，frontmatter 按 `00-System/templates/tpl-draft.md`：status: drafting、authored_by: ai-generated、ai_level: copilot。
4. 同时把 untouched 副本写到 `30-drafts/_baseline/` 同名文件。
5. 行文正面回应 challenges.md 里的反方论据；禁用 `_brief.md` §6 的 Must avoid 词。
6. 完成后汇报：写到了哪、基于哪些素材、还有哪些卡点。
