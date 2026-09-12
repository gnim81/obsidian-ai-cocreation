---
description: One-screen vault status: active projects, draft status distribution, staleness alerts, Inbox backlog
argument-hint: [project name (single project view, optional)]
---
Goal: $ARGUMENTS (empty = full vault overview)

Steps (strictly read-only):
1. Run the deterministic script for the data (**never count by hand — avoid miscounts**):
   `bash 00-System/scripts/status.sh [project-name]`
2. Based on the script output, give 1–3 action suggestions, e.g.:
   - revising drafts exist → "run /produce/iterate to process the human-edited drafts"
   - Inbox backlog > 5 → "run the weekly triage (GUIDE.md §4.3)"
   - a project brief untouched for 2+ weeks → "run /produce/brief to refresh the progress snapshot"
3. Read-only: never modify or create any file.
