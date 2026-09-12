---
description: Update the brief's progress snapshot (§9 + status), auto-summarized from draft states and the journal
argument-hint: <project-name>
---
Goal: $ARGUMENTS

Steps:
1. Read from `03-Projects/<project>/`: `_brief.md`, the last 3 `journal.md` entries, the frontmatter of drafts under `30-drafts/` (status/version/updated), and the filenames in `40-review/` and `50-final/`.
2. Compose the new §9 Current status text: Done: …; In progress (blocked on): …; Next: …. **Evidence comes only from draft states and the journal — never fabricate**; carry over "blockers" from the journal verbatim.
3. Update `_brief.md`: replace §9, sync frontmatter `status` and `updated`.
4. **Touch only these two places.** §1–8 and §10–11 are human-curated strategy — never modify them; if they clearly drifted from reality, list suggested changes separately for my confirmation.
5. Report: a diff summary of your changes + any drift you noticed.
