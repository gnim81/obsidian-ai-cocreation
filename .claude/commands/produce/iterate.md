---
description: Diff the human-edited version against the baseline, then write the next version per the editing intent (old versions untouched)
argument-hint: <project-name> <filename>
---
Goal: $ARGUMENTS

Steps:
1. Diff `30-drafts/_baseline/<file>` against `40-review/<file>`; first summarize what the human edits reveal about intent (structure? tone? cutting redundancy?).
2. Based on that intent, write the new version to `30-drafts/v<next>/`, again double-written with an untouched `_baseline/` copy.
3. Never touch old version directories (v1, v2, …) or `40-review/`.
4. New version frontmatter: status: revising (AI has applied the human's intent; awaiting the next human pass), based_on pointing at the previous version.
5. Report: the editing patterns you read from the diff, and what you changed accordingly.
