---
description: Save a third-party article: fetch/read the original into an Inbox staging file, to be moved into 04-Resources/clippings/ by the human
argument-hint: <URL or local file path or pasted full text> [area]
---
Goal: $ARGUMENTS

Design premise: `04-Resources/clippings/` is the originals layer (AI read-only). This command stages into Inbox; the human moves the file.

Steps:
1. Get the content: URL → fetch the full text (with author/date when possible); local file → read as-is; pasted text → use it.
2. Write the staging file `01-Inbox/<today>-clip-<lowercase-hyphen-slug>.md`:
   - Frontmatter: type: source, source: <URL/file path>, captured: today, area: [<area>] (guess via the CLAUDE.md routing table, flag for confirmation), tags: [source/clipping]
   - Body: the original **kept verbatim** (no rewriting, no abridging, no summarizing), with a "rules" callout at the top (same convention as tpl-source)
3. For very long originals (>10k words), degrade gracefully: stage only frontmatter + a 300-word summary + the source link, and remind me to archive the full text myself and add its path to `source`.
4. Remind me of two things:
   a) Drag the staging file into `04-Resources/clippings/` in Obsidian (wikilinks follow automatically);
   b) After reading, to distill a judgment run `/knowledge/note <area> <my judgment>` — judgments go to Areas, never onto the original.
5. Report: staging path + guessed area + a one-sentence summary (so I can decide whether to read it).

Boundaries: never write `04-Resources/`; never move files via bash; if the content involves interviewees, unpublished data, or others' manuscripts, warn me it must not pass through cloud models.
