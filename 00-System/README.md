# 00-System — 治理层

本目录是 vault 的系统配置层，AI 默认只读。

## 内容

| 路径 | 用途 |
|---|---|
| `templates/` | 项目简报、素材、笔记卡、草稿的 frontmatter 模板 |
| `bases/` | Bases 视图：共创看板 / 待我接管 / AI 参与度审计 |

## 模板使用

1. 在 Obsidian 设置中启用核心插件 **Templates（模板）**（`.obsidian/templates.json` 已预配置模板目录为 `00-System/templates`）。
2. 新建笔记后用命令 "Insert template" 插入；模板中的 `{{date:YYYY-MM-DD}}` 会自动替换为当天日期。
3. 注意：目标笔记已有 frontmatter 时不要重复插入模板，否则会得到两份 frontmatter。

## Bases 视图说明（Obsidian 1.9+ 内置）

- **共创看板**：过滤 `type == "draft"` 且位于 `03-Projects/`，内置 `groupBy: status` 分组展示（装 Kanban Bases View 插件后可拖卡片改状态）。
- **待我接管**：过滤 `status == "revising"`，并带公式列 `stale`（距上次修改的天数），找出停滞的稿子。
- **AI 参与度审计**：列出带 `authored_by` 的文件，供事后核查哪些内容需要重点事实核查。

> 三个视图都用 `file.inFolder("03-Projects")` 排除了模板自身（模板 frontmatter 与草稿同 schema，不排除会混入看板）。若你的 Obsidian 版本打开报错，按报错提示删掉对应过滤行即可，不影响其他功能。
