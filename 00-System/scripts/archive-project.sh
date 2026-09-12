#!/usr/bin/env bash
# Archive a project (mechanical part): status→archived + git mv into 05-Archive/<year>
# Usage: bash 00-System/scripts/archive-project.sh <project-name> [-y]
# Conclusion extraction, _INDEX cleanup, and the commit are done by the human / in-session AI (see /produce/archive)
set -euo pipefail
cd "$(dirname "$0")/../.."

name="${1:?Usage: archive-project.sh <project-name> [-y]}"
shift || true
assume="${1:-}"
dir="03-Projects/$name"

[ -d "$dir" ] || { echo "✗ Not found: $dir"; exit 1; }
[ -f "$dir/_brief.md" ] || { echo "✗ Missing _brief.md"; exit 1; }
ls "$dir"/50-final/*.md >/dev/null 2>&1 || echo "⚠ 50-final/ is empty — sure you want to archive?"
[ -f "$dir/journal.md" ] || echo "⚠ Missing journal.md (no retrospective)"

if [ "$assume" != "-y" ]; then
  read -r -p "Confirm archiving $name? [y/N] " a
  case "$a" in y|Y*) ;; *) echo "Cancelled"; exit 0;; esac
fi

today=$(date +%F); year=${today:0:4}
sed -i "s/^status:.*/status: archived/" "$dir/_brief.md"
sed -i "s/^updated:.*/updated: $today/" "$dir/_brief.md"
mkdir -p "05-Archive/$year"
if git mv "$dir" "05-Archive/$year/" 2>/dev/null; then
  moved="git mv"
else
  # git mv refuses when files are untracked — fall back to plain mv (picked up by the next commit)
  mv "$dir" "05-Archive/$year/"
  moved="mv (contains uncommitted files, lands in the next commit)"
fi

echo "✓ Archived → 05-Archive/$year/$name ($moved)"
echo "→ TODO (in-session AI may draft; the human lands it): distill 2–3 long-term conclusions from journal.md into 02-Areas"
echo "→ TODO: remove the project row from _INDEX.md"
echo "→ Commit manually: git add -A && git commit -m \"archive: $name\""
