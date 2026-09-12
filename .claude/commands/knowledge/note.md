---
description: Write or revise area judgments: new judgments staged into Inbox + paste-ready deltas; revisions proposed as changelogs (never overwrites)
argument-hint: <area> <new judgment, or: revise <note path>: new evidence>
---
Goal: $ARGUMENTS

Design premise: `02-Areas/` is the AI read-only knowledge layer. This command uses a "stage + paste-ready" mode; landing and revising are done by the human (mechanism: GUIDE.md §4.12 write/revise/return).

**Branch A — new judgment** (the argument is the judgment itself):
1. Confirm `02-Areas/<area>/` exists (see the CLAUDE.md routing table); if not, stop and print the new-area setup instructions (GUIDE.md §9.1) — never create it yourself.
2. Write the staging note `01-Inbox/<today>-area-<area>-<lowercase-hyphen-slug>.md` (Inbox is AI-writable):
   - Frontmatter: type: area-note, area: <area>, authored_by: ai-assisted (AI distilled) or human (pure transcription), created: today
   - Body: conclusion first + evidence links; my original words in quote blocks; AI-distilled parts clearly marked
3. Output the paste-ready `_context.md` delta (which lines, which section, with provenance), marked "review before pasting; adding a line means considering which line to drop" (500-word cap).
4. Remind me: drag the staging note into `02-Areas/<area>/` in Obsidian (wikilinks follow automatically).

**Branch B — revise an existing judgment** (the argument contains "revise" + a note path):
1. Read that note and my new evidence.
2. Generate a paste-ready revision in changelog format (never edit directly — 02-Areas is read-only):
   ```
   YYYY-MM revision: <new conclusion / new evidence / sample-size change>
   original (YYYY-MM): <kept verbatim>
   ```
3. If the judgment is compressed inside `_context.md`, also output the replacement line for it.
4. Remind me: updating cognition is a changelog, not an overwrite — preserve the evolution trail and the evidence size.

Boundaries: only ever write inside `01-Inbox/`; never move files into `02-Areas/` via bash mv/git mv; the move and the paste are done by me in Obsidian.
