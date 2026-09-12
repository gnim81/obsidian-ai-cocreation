#!/usr/bin/env bash
# Vault status overview (read-only) — deterministic data source for /query/status
# Usage: bash 00-System/scripts/status.sh [project]
set -uo pipefail
cd "$(dirname "$0")/../.."

# Read a scalar frontmatter field: fm <file> <key>
fm() { awk -v k="$2" 'BEGIN{c=0} /^---[[:space:]]*$/{c++; next} c==1 && $0 ~ "^"k":" {sub(/^[^:]*:[[:space:]]*/,"",$0); gsub(/^"|"$/,"",$0); print; exit}' "$1"; }

only="${1:-}"
today=$(date +%s)

echo "# Vault status overview ($(date +%F))"

echo
echo "## Projects (03-Projects)"
for b in 03-Projects/*/_brief.md; do
  [ -f "$b" ] || continue
  p=$(basename "$(dirname "$b")")
  [ -n "$only" ] && [ "$p" != "$only" ] && continue
  echo "- $p — status: $(fm "$b" status) · updated: $(fm "$b" updated)"
done

echo
echo "## Draft status distribution (30-drafts versions + 40-review; historical versions counted)"
for f in 03-Projects/*/30-drafts/v*/*.md 03-Projects/*/40-review/*.md; do
  [ -f "$f" ] || continue
  [ -n "$only" ] && [[ "$f" != 03-Projects/"$only"/* ]] && continue
  s=$(fm "$f" status); [ -z "$s" ] && s="(no status)"
  echo "$s"
done | sort | uniq -c | sed 's/^ *//' | while read -r n s; do echo "- $s: $n"; done

echo
echo "## Stalled drafts (updated >7 days ago, not final/published/archived)"
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
  if [ "$age" -gt 7 ]; then echo "- $f (${age} days stale, status: $s)"; found=1; fi
done
[ "$found" = 0 ] && echo "- (none)"

echo
n=$(find 01-Inbox -maxdepth 1 -name '*.md' ! -name 'README.md' 2>/dev/null | wc -l)
echo "## Inbox backlog: $n items (README excluded)"
