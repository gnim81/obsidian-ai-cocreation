# obsidian-ai-cocreation

> 让 AI 安全地住进你的 Obsidian 知识库——带**权限边界**、**人机分工**与**可审计迭代**的 AI 共创模板。

[English](README.en.md) · MIT License

---

## 它解决什么问题

把 AI agent 接入知识库写作，普遍撞上三堵墙：

1. **不敢让它写**——AI 一旦能写，你的原始素材、长期笔记、定稿全暴露在被误改的风险下；
2. **每次都要重新解释**——背景、受众、文风、禁忌，换个会话就清零；
3. **人机贡献说不清**——哪段是 AI 写的？事后想核查，无从下手。

本模板用一套**被执行的边界**（而非提示词约定）+ **上下文资产** + **基线审计**来回应：

```
┌─────────────────────────────────────────────────────────┐
│  L1  MCP vault-root 钉死：project-rw 只能写 03-Projects/   │
│  L2  .claude/settings.json deny：禁写素材/定稿/领域/治理文件  │
│  L3  Vault Operator（可选）：管住 Obsidian 内 AI 插件       │
│  L4  human_locked 字段锁：你接管的文件 AI 只能提议修改       │
└─────────────────────────────────────────────────────────┘
```

每层都标注了"谁来执行、管哪条路径"——包括实测结论：L3 的影子快照**不记录外部工具直写**，外部路径的后悔药是 git（一轮共创一 commit）。

## 核心设计

**三层内容模型**（一篇东西放哪的判断标准）：

| 层 | 位置 | 放什么 | 谁写 |
|---|---|---|---|
| 原文层 | `04-Resources/clippings/` | 第三方文章原样收藏 | 你（AI 备料） |
| 结论层 | `02-Areas/<领域>/` | 你的判断（"我"开头、两年有效） | 只有人（AI 出提案） |
| 原料层 | `03-Projects/<项目>/10-source/` | 服务当前创作的素材 | 只有你 |

一句话：**Projects 产出作品，Clippings 收别人的原文，Areas 存我的判断。**

**项目内四层分区**（AI 权限的物理边界）：`10-source` 只读 → `20-notes` 可写 → `30-drafts` 可写（v1/v2 永不覆盖 + `_baseline/` 存 untouched 副本）→ `40-review`/`50-final`/`60-published` 禁写。

**人机分工四模式**：脚本执行（纯机械）/ AI 直写（可写区）/ AI 备料+人工落库（信任层）/ AI 建议+人工拍板（破坏性操作）。

**开箱即用的操作层**：14 个斜杠命令（按功能五组）+ 3 个确定性 bash 脚本：

| 功能组 | 命令 |
|---|---|
| 收进来 `/intake/` | `collect` `clip` `triage` |
| 做出来 `/produce/` | `new` `digest` `draft` `iterate` `brief` `archive` |
| 沉淀下 `/knowledge/` | `note` |
| 把好关 `/quality/` | `factcheck` `voice` |
| 查得到 `/query/` | `search` `status` |

脚本（`00-System/scripts/`）承担建目录/移动/统计等确定性操作——零幻觉、零 token、可脱离 AI 会话运行；AI 只做判断性环节。另含：状态机（idea→…→archived）、AI 参与度标注（`authored_by`/`ai_level`）、Bases 看板 ×3、写作模板 ×3。

## 快速开始

```bash
git clone https://github.com/<you>/obsidian-ai-cocreation.git my-vault
cd my-vault
bash init-vault.sh                 # 可选：--areas "写作,编程,投资" 自定义领域
```

然后：① Obsidian 打开 `my-vault`（信任插件，核心插件里开启「模板」）；② 在 `my-vault` 目录启动你的 AI CLI（如 `claude`），批准两个 MCP server；③ 读 [使用指南.md](使用指南.md) 跑第一个项目。

- 主方式是**外部 AI 工具 + MCP**（Claude Code / Codex CLI / Cursor 等）；[Claudian](https://github.com/YishenTu/claudian) 等 Obsidian 内 AI 插件为可选增强，不装不影响任何功能。
- Linux/macOS：用 `.mcp.linux.json` 覆盖 `.mcp.json`（init 脚本已自动生成对应路径版本）。
- 社区插件**没有必须装的**；可选：Vault Operator（管 Obsidian 内 AI 写入）、Kanban Bases View（看板拖拽）。

## 目录速览

```
├── CLAUDE.md            AI 宪法（权限+硬规则+领域路由表，AI 每次会话先读）
├── 使用指南.md           人的操作手册（9 章）
├── init-vault.sh        一键初始化（填 MCP 路径 / 自定义领域 / git init）
├── .claude/             权限规则 + 14 个斜杠命令
├── .mcp.json            MCP 双实例：vault-read 全库只读 / project-rw 钉死共创区
├── 00-System/           模板、Bases 看板、确定性脚本
├── 01-Inbox/            唯一入口，每周清空（AI 可写）
├── 02-Areas/            长期领域：你的判断（AI 只读）
├── 03-Projects/         共创区（AI 受限可写），含示例项目
├── 04-Resources/        clippings 原文层 + 风格库（AI 只读）
└── 05-Archive/          归档（AI 只读）
```

## 设计出处与参考

- [The PARA Method — Forte Labs](https://fortelabs.com/blog/para/)
- [bitbonsai/mcpvault](https://github.com/bitbonsai/mcpvault) · MCP 双实例与子目录钉死
- [Claude Code — Configure permissions](https://code.claude.com/docs/en/permissions) · deny 语法与已知局限
- [Writing Academic Papers with Claude + Obsidian](https://dhcraft.org/academic-writing-with-ai/) · vault 结构与 baseline 实践
- [How I Built My AI Content Pipeline With Obsidian and Claude](https://www.thedaringcreatives.com/ai-content-pipeline-obsidian-claude/) · voice-reference 与状态机
- [AI-DECLARATION 规范](https://www.producthunt.com/r/ZSBJPCPJOYLNN2) · AI 参与度六级量表
- [Obsidian Bases](https://help.obsidian.md/bases/syntax) · 看板视图语法

## License

[MIT](LICENSE)
