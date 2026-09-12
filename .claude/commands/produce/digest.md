---
description: Digest project sources into 20-notes cards (each card links back to its source)
argument-hint: <project-name>
---
Goal: $ARGUMENTS

Steps:
1. Read `03-Projects/<project>/_brief.md`, then scan all material under `10-source/` (clippings / interviews / sparks).
2. Produce one card per item (summary / claim / case card) into `20-notes/`, with frontmatter per `00-System/templates/tpl-note-card.md`.
3. Every card must end with a link back to its source (full-path wikilink `[[10-source/…]]`) — provenance is mandatory.
4. `10-source/` is read-only: never rewrite, move, or delete any source file.
5. Report: which cards were produced and which sources were low-signal enough to skip.
