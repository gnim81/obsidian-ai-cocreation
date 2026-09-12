#!/usr/bin/env bash
# Create a new creation project scaffold (deterministic) — mechanical part of /produce/new
# Usage: bash 00-System/scripts/new-project.sh <project-name> [mini]
set -euo pipefail
cd "$(dirname "$0")/../.."

name="${1:?Usage: new-project.sh <project-name> [mini]}"
mode="${2:-full}"
dir="03-Projects/$name"

case "$name" in *[/\\]*|.*|'') echo "✗ Invalid project name: $name"; exit 1;; esac
[ -e "$dir" ] && { echo "✗ Already exists: $dir (never overwrite)"; exit 1; }

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
# Brief: $name

> AI reads this file at the start of every session. Keep it under 500 words; update when stale.

## 1. One-sentence goal
(required: what readers walk away with)
## 2. Deliverables
Format / length / platforms:
## 3. Audience
Role / already knows / fears / change after reading:
## 4. Core angle (vs. typical content)
## 5. Voice & style
Reference: [[04-Resources/voice-reference]]
## 6. Must include / Must avoid
Include:
Avoid: fabricating data/cases; income promises;
## 7. Sources & facts
-
## 8. Outline (current)
01 …
## 9. Current status
Done: / In progress (blocked on): / Next:
## 10. Acceptance criteria (pass/fail)
1)
## 11. Permission boundaries
AI may write: 30-drafts/, 20-notes/; forbidden: 10-source/, 40-review/, 50-final/, 02-Areas/.
EOF

cat > "$dir/challenges.md" <<EOF
---
type: challenges
topic: "[[03-Projects/$name/_brief|$name]]"
updated: $today
---
# challenges: the strongest arguments against this project

> Anti-echo-chamber: the AI must read this before co-writing and address these head-on.

## Counter-arguments
1. (fill in: 2–3 strongest arguments against your position)

## Response tracker

| # | Status | Addressed in |
|---|---|---|
| 1 | open | |
EOF

cat > "$dir/journal.md" <<EOF
---
type: journal
topic: "[[03-Projects/$name/_brief|$name]]"
updated: $today
---
# journal: process log

## $today
- Done: project initialized (script scaffold).
- Learned: —
- Next: fill in the four key brief sections (§1/§3/§6/§10).
EOF

echo "✓ Project created: $dir (mode=$mode)"
echo
echo "═══ Paste 1 · _INDEX.md, add a row under \"Active projects\" ═══"
echo "| $name | active | [[03-Projects/$name/_brief\\|brief]] |"
echo
echo "═══ Paste 2 · related area _context.md, add under \"Related projects\" (confirm the area first) ═══"
echo "- [[03-Projects/$name/_brief|$name]]"
echo
echo "→ Fill in brief §1/§3/§6/§10 before co-writing; write at least 2 counter-arguments in challenges.md."
