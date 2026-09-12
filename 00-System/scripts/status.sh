#!/usr/bin/env bash
# 库状态总览（只读）——/query/status 的确定性数据源
# 用法：bash 00-System/scripts/status.sh [项目名]
set -uo pipefail
cd "$(dirname "$0")/../.."

# 取 frontmatter 标量字段：fm <文件> <键>
fm() { awk -v k="$2" 'BEGIN{c=0} /^---[[:space:]]*$/{c++; next} c==1 && $0 ~ "^"k":" {sub(/^[^:]*:[[:space:]]*/,"",$0); gsub(/^"|"$/,"",$0); print; exit}' "$1"; }

only="${1:-}"
today=$(date +%s)

echo "# Vault 状态总览（$(date +%F)）"

echo
echo "## 项目（03-Projects）"
for b in 03-Projects/*/_brief.md; do
  [ -f "$b" ] || continue
  p=$(basename "$(dirname "$b")")
  [ -n "$only" ] && [ "$p" != "$only" ] && continue
  echo "- $p — status: $(fm "$b" status) · updated: $(fm "$b" updated)"
done

echo
echo "## 稿件状态分布（30-drafts 各版本 + 40-review，历史版本计入）"
for f in 03-Projects/*/30-drafts/v*/*.md 03-Projects/*/40-review/*.md; do
  [ -f "$f" ] || continue
  [ -n "$only" ] && [[ "$f" != 03-Projects/"$only"/* ]] && continue
  s=$(fm "$f" status); [ -z "$s" ] && s="(无status)"
  echo "$s"
done | sort | uniq -c | sed 's/^ *//' | while read -r n s; do echo "- $s: $n"; done

echo
echo "## 停滞稿件（updated 距今 >7 天，未 final/published/archived）"
found=0
for f in 03-Projects/*/30-drafts/v*/*.md 03-Projects/*/40-review/*.md; do
  [ -f "$f" ] || continue
  [ -n "$only" ] && [[ "$f" != 03-Projects/"$only"/* ]] && continue
  s=$(fm "$f" status)
  case "$s" in final|published|archived|"") continue;; esac
  u=$(fm "$f" updated); [ -z "$u" ] && continue
  e=$(date -d "$u" +%s 2>/dev/null) || continue
  [ -z "$e" ] && continue
  age=$(( (today - e) / 86400 ))
  if [ "$age" -gt 7 ]; then echo "- $f（${age} 天未更新，status: $s）"; found=1; fi
done
[ "$found" = 0 ] && echo "-（无）"

echo
n=$(find 01-Inbox -maxdepth 1 -name '*.md' ! -name 'README.md' 2>/dev/null | wc -l)
echo "## Inbox 积压：$n 条（README 除外）"
