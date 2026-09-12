---
description: Analyze human editing patterns and produce a voice-update for merging into the voice reference
argument-hint: <project-name> <filename>
---
Goal: $ARGUMENTS

Steps:
1. Diff `30-drafts/_baseline/<file>` against `40-review/<file>`.
2. Distill the editing patterns: what does he delete (e.g. flowery metaphors)? what does he add (e.g. first-hand observations)? sentence and structure preferences?
3. Write `20-notes/voice-update-<today>.md`, each pattern backed by diff evidence (one sentence before and after).
4. **Never write into `04-Resources/`** (voice-reference is merged by the human after review).
5. Report: the 3–5 most prominent patterns, summarized in one sentence.
