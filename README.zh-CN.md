# obsidian-ai-cocreation

> 让 AI 安全地住进你的 Obsidian 知识库——带**权限边界**、**人机分工**与**可审计迭代**的 AI 共创模板。

[English](README.md) · [完整指南（英文）](GUIDE.md) · MIT License

> 说明：本仓库已全面英文化，此页为中文简介；详细操作手册见 [GUIDE.md](GUIDE.md)（英文）。

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

**开箱即用的操作层**：14 个斜杠命令（按功能五组 `/intake/` `/produce/` `/knowledge/` `/quality/` `/query/`）+ 3 个确定性 bash 脚本（建目录/移动/统计——零幻觉、零 token、可脱离 AI 会话运行）。另含：状态机（idea→…→archived）、AI 参与度标注（`authored_by`/`ai_level`）、Bases 看板 ×3、写作模板 ×3。

## 快速开始

```bash
git clone https://github.com/gnim81/obsidian-ai-cocreation.git my-vault
cd my-vault
bash init-vault.sh                 # 可选：--areas "写作,编程,投资" 自定义领域
```

然后：① Obsidian 打开 `my-vault`（信任插件，核心插件里开启「模板」）；② 在 `my-vault` 目录启动你的 AI CLI（如 `claude`），批准两个 MCP server；③ 读 [GUIDE.md](GUIDE.md) 跑第一个项目。

- 主方式是**外部 AI 工具 + MCP**（Claude Code / Codex CLI / Cursor 等）；[Claudian](https://github.com/YishenTu/claudian) 等 Obsidian 内 AI 插件为可选增强，不装不影响任何功能。
- Linux/macOS：用 `.mcp.linux.json` 覆盖 `.mcp.json`（init 脚本已自动生成对应路径版本）。
- 社区插件**没有必须装的**。

## 设计出处与参考

- [The PARA Method — Forte Labs](https://fortelabs.com/blog/para/)
- [bitbonsai/mcpvault](https://github.com/bitbonsai/mcpvault)
- [Claude Code — Configure permissions](https://code.claude.com/docs/en/permissions)
- [Writing Academic Papers with Claude + Obsidian](https://dhcraft.org/academic-writing-with-ai/)
- [AI Content Pipeline with Obsidian and Claude](https://www.thedaringcreatives.com/ai-content-pipeline-obsidian-claude/)

## License

[MIT](LICENSE)
