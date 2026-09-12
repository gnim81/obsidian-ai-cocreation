#!/usr/bin/env bash
# 归档项目（机械部分）：status→archived + git mv 到 05-Archive/<年>
# 用法：bash 00-System/scripts/archive-project.sh <项目名> [-y]
# 结论提炼、_INDEX 删行、commit 由人/会话内 AI 完成（见 /produce/archive）
set -euo pipefail
cd "$(dirname "$0")/../.."

name="${1:?用法: archive-project.sh <项目名> [-y]}"
shift || true
assume="${1:-}"
dir="03-Projects/$name"

[ -d "$dir" ] || { echo "✗ 不存在：$dir"; exit 1; }
[ -f "$dir/_brief.md" ] || { echo "✗ 缺 _brief.md"; exit 1; }
ls "$dir"/50-final/*.md >/dev/null 2>&1 || echo "⚠ 50-final/ 无定稿——确认真的要归档？"
[ -f "$dir/journal.md" ] || echo "⚠ 缺 journal.md（复盘缺失）"

if [ "$assume" != "-y" ]; then
  read -r -p "确认归档 $name？[y/N] " a
  case "$a" in y|Y*) ;; *) echo "已取消"; exit 0;; esac
fi

today=$(date +%F); year=${today:0:4}
sed -i "s/^status:.*/status: archived/" "$dir/_brief.md"
sed -i "s/^updated:.*/updated: $today/" "$dir/_brief.md"
mkdir -p "05-Archive/$year"
if git mv "$dir" "05-Archive/$year/" 2>/dev/null; then
  moved="git mv"
else
  # 项目含未提交文件时 git mv 会拒绝，退回普通 mv（提交时一并入库）
  mv "$dir" "05-Archive/$year/"
  moved="mv（含未提交文件，下次 commit 时入库）"
fi

echo "✓ 已归档 → 05-Archive/$year/$name（$moved）"
echo "→ 待办（会话内 AI 可代办提议，落笔人工）：从 journal 提炼 2–3 条结论回写 02-Areas"
echo "→ 待办：_INDEX.md 删除该项目行"
echo "→ 手动提交：git add -A && git commit -m \"archive: $name\""
