---
description: Create a new creation project: script scaffold + AI fills the brief + paste-ready index rows
argument-hint: <project-name> [mini] [one-line description]
---
Goal: $ARGUMENTS (project name required; add mini for a single-article project; optionally a one-line description for the brief)

Division of labor: the directory scaffold and the three skeleton files are done by a deterministic script (zero hallucination); you only do the judgment parts.

Steps:
1. Confirm `03-Projects/<project-name>/` does not exist; if it does, stop and ask me — never overwrite.
2. Run the script: `bash 00-System/scripts/new-project.sh <project-name> [mini]`
   (It creates empty directories — no placeholder files land in write-forbidden zones like `10-source/`; generates the `_brief/challenges/journal` skeletons; prints two paste-ready rows.)
3. Fill the parts of `_brief.md` you can determine from the one-line description (guess the area via the CLAUDE.md routing table and flag it for confirmation); leave placeholders for the rest — never invent.
4. Verify the script's paste-ready content (the `_INDEX.md` table row + the related area `_context.md` wikilink row); correct the area guess if wrong before presenting it.
5. **Never modify `_INDEX.md` or `02-Areas/*/_context.md` (AI write-forbidden)** — pasting is done by me.
6. Remind me: fill brief §1/§3/§6/§10 before starting `/produce/draft`; write at least 2 counter-arguments in `challenges.md`; (optional) bookmark `_brief.md`.
7. Report the final directory tree.
