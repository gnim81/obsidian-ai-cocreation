#!/usr/bin/env bash
# obsidian-ai-cocreation · one-command init
# Usage:
#   bash init-vault.sh                      # personalize in place (run at the repo root after git clone)
#   bash init-vault.sh /path/to/new-vault   # copy the template to a new directory, then personalize
#   Optional: --areas "AreaA,AreaB,AreaC"   (default: keep the five example areas)
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
TARGET=""
AREAS=""

while [ $# -gt 0 ]; do
  case "$1" in
    --areas) AREAS="${2:?--areas requires a value}"; shift 2 ;;
    *) TARGET="$1"; shift ;;
  esac
done

# 0) Target directory: with an argument, copy the template; without, personalize the clone in place
if [ -n "$TARGET" ]; then
  mkdir -p "$TARGET"
  TARGET="$(cd "$TARGET" && pwd)"
  tar -C "$SRC" --exclude=./.git -cf - . | tar -C "$TARGET" -xf -
  echo "✓ Template copied → $TARGET"
else
  TARGET="$SRC"
fi

# 1) Fill in the MCP absolute paths (.mcp.json uses Windows mixed style, .mcp.linux.json uses POSIX)
MIX_PATH="$(command -v cygpath >/dev/null 2>&1 && cygpath -m "$TARGET" || realpath "$TARGET")"
POS_PATH="$(command -v cygpath >/dev/null 2>&1 && cygpath -u "$TARGET" || realpath "$TARGET")"
sed -i "s|__VAULT_PATH__|$MIX_PATH|g" "$TARGET/.mcp.json"
sed -i "s|__VAULT_PATH__|$POS_PATH|g" "$TARGET/.mcp.linux.json"
echo "✓ MCP paths written ($MIX_PATH)"

# 2) Custom areas (keep the five example areas when not provided and non-interactive)
if [ -z "$AREAS" ] && [ -t 0 ]; then
  read -r -p "Custom areas (comma-separated, Enter = keep the five example areas): " INPUT
  AREAS="$INPUT"
fi

if [ -n "$AREAS" ]; then
  IFS=',' read -ra ARR <<< "$AREAS"
  rm -rf "$TARGET"/02-Areas/*
  rows=""
  idx=""
  today="$(date +%F)"
  for a in "${ARR[@]}"; do
    a="$(echo "$a" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
    [ -z "$a" ] && continue
    case "$a" in *[/\\]*) echo "✗ Invalid area name: $a"; exit 1 ;; esac
    mkdir -p "$TARGET/02-Areas/$a"
    cat > "$TARGET/02-Areas/$a/_context.md" <<EOF
---
type: area-context
area: $a
updated: $today
---
# _context: $a

> Compressed context for this area, under 500 words. When routing keywords hit, read this first, then dig deeper.

## What this area is
A long-term Area, never "done". AI reads this directory only; creative output goes to 03-Projects/, soft-linked via frontmatter area fields.

## Current focus
-

## Key conclusions / verified judgments
-

## Related projects
-
EOF
    rows="${rows}| $a | [[02-Areas/$a/_context]] | $a (add trigger keywords) |
"
    idx="${idx}- [[02-Areas/$a/_context|$a]]
"
  done
  if [ -z "$rows" ]; then echo "✗ Area list is empty"; exit 1; fi
  awk -v rows="$rows" '/<!--area-rows-start-->/{print; printf "%s", rows; skip=1; next} /<!--area-rows-end-->/{skip=0} !skip' "$TARGET/CLAUDE.md" > "$TARGET/CLAUDE.md.tmp" && mv "$TARGET/CLAUDE.md.tmp" "$TARGET/CLAUDE.md"
  awk -v idx="$idx" '/<!--area-rows-start-->/{print; printf "%s", idx; skip=1; next} /<!--area-rows-end-->/{skip=0} !skip' "$TARGET/_INDEX.md" > "$TARGET/_INDEX.md.tmp" && mv "$TARGET/_INDEX.md.tmp" "$TARGET/_INDEX.md"
  echo "✓ Areas generated (remember to add trigger keywords in each _context.md and the CLAUDE.md routing table)"
fi

# 3) git (init in copy mode; reuse the clone's .git in in-place mode)
if [ ! -d "$TARGET/.git" ]; then
  git -C "$TARGET" init -q
  git -C "$TARGET" add -A
  git -C "$TARGET" -c user.name="init" -c user.email="init@local" commit -qm "init: obsidian-ai-cocreation"
  echo "✓ git initialized with the first commit"
fi

cat <<'EOF'

Init complete. Next steps:
  1. Open this directory in Obsidian as a vault; trust & enable plugins;
  2. Settings → Core plugins → enable "Templates" (template folder is preconfigured);
  3. Launch your external AI CLI (e.g. claude) at this directory; approve the two MCP servers;
  4. Read GUIDE.md chapter 4 to start your first project (or just run /produce/new).
  Full docs: README.md and GUIDE.md.
EOF
