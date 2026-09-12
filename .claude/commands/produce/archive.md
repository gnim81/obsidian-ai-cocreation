---
description: Archive a finished project (soft delete): script moves it into 05-Archive; AI distills conclusions for write-back
argument-hint: <project-name>
---
Goal: $ARGUMENTS

Division of labor: the mechanical parts (status flip, directory move) are done by a deterministic script; you handle pre-checks and conclusion extraction.

Pre-checks (stop and ask me if anything is off — never guess):
1. `03-Projects/<project>/` exists; `_brief.md` §9 shows the project wrapped up.
2. `50-final/` contains a final version and `journal.md` has a closing retrospective — if missing, remind me to fill them first.

Steps:
1. After my confirmation, run: `bash 00-System/scripts/archive-project.sh <project-name> -y`
   (The script does: status→archived, updated refresh, move into `05-Archive/<year>/`; falls back to plain mv when uncommitted files are present.)
2. **Never modify `_INDEX.md` or `02-Areas/*/_context.md` (AI write-forbidden).** Instead, output paste-ready content:
   a) Remind me to delete the project's row from `_INDEX.md` "Active projects";
   b) Distill 2–3 long-term conclusions from the `journal.md` retrospective (each with provenance), marked "paste after human review" into the related area's `_context.md`.
3. Remind me: writing conclusions back to Areas is the core value of archiving (the flywheel) — don't skip it; then commit manually: `git add -A && git commit -m "archive: <project-name>"`. Obsidian follows the move and updates wikilinks automatically.
4. Report: paths before/after the move, and the distilled conclusion list.

Note: this command is the vault's only "delete" — a **soft delete (archive)**. Hard deletes (rm) are denied for AI and executed by the human.
