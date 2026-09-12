#!/usr/bin/env bash
# 新建创作项目脚手架（确定性）——/produce/new 的机械部分
# 用法：bash 00-System/scripts/new-project.sh <项目名> [mini]
set -euo pipefail
cd "$(dirname "$0")/../.."

name="${1:?用法: new-project.sh <项目名> [mini]}"
mode="${2:-full}"
dir="03-Projects/$name"

case "$name" in *[/\\]*|.*|'') echo "✗ 非法项目名：$name"; exit 1;; esac
[ -e "$dir" ] && { echo "✗ 已存在：$dir（不得覆盖）"; exit 1; }

if [ "$mode" = "mini" ]; then
  mkdir -p "$dir"/{10-source,30-drafts/{v1,_baseline},50-final}
else
  mkdir -p "$dir"/{10-source/{clippings,interviews,sparks},20-notes,30-drafts/{v1,_baseline},40-review,50-final,60-published}
fi
today=$(date +%F)

cat > "$dir/_brief.md" <<EOF
---
type: project-brief
topic: $name
area: []
status: active
updated: $today
---
# 简报：$name

> AI 每次会话先读本文件。全文控制在 500 词内，过时立即更新。

## 1. 一句话目标
（必填：读者读完能得到什么）
## 2. 交付物
形式 / 篇幅 / 平台：
## 3. 受众
角色 / 已知 / 担心 / 读后改变：
## 4. 核心角度（与常见内容的差异）
## 5. 声音与风格
范文：[[04-Resources/voice-reference]]
## 6. Must include / Must avoid
必含：
禁止：编造数据/案例；承诺收益；
## 7. 素材与事实来源
-
## 8. 结构（当前版）
01 …
## 9. 当前进展
已完成： / 进行中（卡点）： / 下一步：
## 10. 验收标准（pass/fail）
1)
## 11. 权限边界
AI 可写：30-drafts/、20-notes/；禁止写入：10-source/、40-review/、50-final/、02-Areas/。
EOF

cat > "$dir/challenges.md" <<EOF
---
type: challenges
topic: "[[03-Projects/$name/_brief|$name]]"
updated: $today
---
# challenges：反对本项目的最强论据

> 防回音室：AI 共创前必读，行文必须正面回应而非回避。

## 反方论据
1. （待填：写入 2–3 条反对立场的最强论据）

## 待回应状态

| 论据 | 状态 | 回应位置 |
|---|---|---|
| 1 | 未回应 | |
EOF

cat > "$dir/journal.md" <<EOF
---
type: journal
topic: "[[03-Projects/$name/_brief|$name]]"
updated: $today
---
# journal：过程日志

## $today
- 做了：项目初始化（脚本脚手架）。
- 学到：—
- 下一步：填 _brief.md 关键四节（§1/§3/§6/§10）。
EOF

echo "✓ 项目已创建：$dir（mode=$mode）"
echo
echo "═══ 待粘贴 1：_INDEX.md「进行中的创作主题」加一行 ═══"
echo "| $name | active | [[03-Projects/$name/_brief\\|简报]] |"
echo
echo "═══ 待粘贴 2：相关领域 _context.md「相关项目」加链接（领域请人工确认）═══"
echo "- [[03-Projects/$name/_brief|$name]]"
echo
echo "→ 填完 _brief.md §1/§3/§6/§10 再开始共创；challenges.md 至少写 2 条反方论据。"
