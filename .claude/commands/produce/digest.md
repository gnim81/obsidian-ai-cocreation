---
description: 把项目 10-source 素材加工成 20-notes 笔记卡（每卡回链出处）
argument-hint: <项目名>
---
目标：$ARGUMENTS

步骤：
1. 读 `03-Projects/<项目>/_brief.md`，然后扫 `10-source/` 下全部素材（clippings / interviews / sparks）。
2. 每篇素材产出一张摘要卡（或论点卡/案例卡）到 `20-notes/`，frontmatter 按 `00-System/templates/tpl-note-card.md`。
3. 每张卡末尾必须回链素材出处（`[[10-source/...]]` 全路径 wikilink），保证可溯源。
4. `10-source/` 只读：不得改写、移动、删除任何素材文件。
5. 汇总：产出了哪些卡、哪些素材信息量低可忽略。
