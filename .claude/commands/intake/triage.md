---
description: Weekly Inbox triage: analyze each item's destination and produce an execution plan (moves/deletes are executed by the human)
argument-hint: [filter, empty = all]
---
Goal: $ARGUMENTS (empty = all Inbox items)

Steps:
1. List everything in `01-Inbox/` (except README.md).
2. For each item, pick one of three destinations:
   a) **Current project source** → `03-Projects/<p>/10-source/{clippings,interviews,sparks}/` (projects with `status: active` in their `_brief.md`);
   b) **Area-related** → originals go to `04-Resources/clippings/` (same destination as /intake/clip); judgments go to `02-Areas/<area>/` (chain into /knowledge/note for the distilled version);
   c) **No value** → recommend deletion.
3. Output an execution plan table: item | suggested destination | one-line reason | follow-up command.
4. After my confirmation, do the parts within your permissions first: add tpl-source-style frontmatter for items heading to (a) — renaming within `01-Inbox/` is fine; **list the moves and deletions for me to execute by hand** (10-source/04-Resources/02-Areas are AI write-forbidden; rm is denied — those must be human).
5. Report: remaining Inbox count + the checklist awaiting my execution.
