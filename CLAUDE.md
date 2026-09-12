# Vault Constitution (required reading for AI)

This vault follows a PARA structure. At the start of any session, read this file first, then use the routing table to locate context. **Do not blind-scan the vault.**

## 1. Directory map & permission boundaries

```
00-System/       governance: templates, boards, scripts     read-only
01-Inbox/        single entry point, cleared weekly         writable
02-Areas/        long-term areas (your judgments)           read-only
03-Projects/     active creation projects (co-writing zone)  write-limited (see below)
04-Resources/    clippings originals + voice reference      read-only
05-Archive/      archived projects                          read-only
```

### Inside 03-Projects/<project>/

| Zone | Directory | AI permission |
|---|---|---|
| Sources | `10-source/` | **Read-only. Never rewrite, never delete** (append-only, maintained by the human) |
| Notes | `20-notes/` | Read-write (summary cards, claims, case cards — each must link back to its source) |
| Drafts | `30-drafts/` | Read-write (new versions go to v2/, v3/ — never overwrite old versions) |
| Review | `40-review/` | Read-only (the version the human is editing) |
| Final | `50-final/` | **Write-forbidden** |
| Published | `60-published/` | Read-only |

## 2. Hard rules

1. **Read `_brief.md` and `challenges.md` first**: on entering `03-Projects/<project>/`, always read its `_brief.md` (goal / audience / voice / must-include & must-avoid / acceptance criteria / current status) and treat it as authoritative — do not improvise. If the project has a `challenges.md` (strongest counter-arguments), address those arguments head-on; never dodge them or reinforce an echo chamber.
2. **`10-source/` may only be quoted, excerpted, structured, and linked** — never rewritten. Excerpts go in `>` quote blocks that stay untouched; annotations are written below.
3. **AI drafts must be double-written**: when writing a draft to `30-drafts/vN/`, simultaneously save an untouched copy with the same filename to `30-drafts/_baseline/` for human diff auditing.
4. **Files with `human_locked: true`** are propose-edit only — never write to them directly.
5. **No fabrication**: data, cases, and citations must trace back to `10-source/` or an external URL; words listed in the brief's "Must avoid" are forbidden.
6. **AI participation labels**: every output carries frontmatter `authored_by` (human | ai-assisted | ai-generated), `ai_level` (none/hint/assist/pair/copilot/auto), `ai_model`.
7. **State machine**: idea → outline → drafting → revising → review → final → published → archived. When updating a file, sync its frontmatter `status` and `updated`.
8. **Naming**: filenames are lowercase-hyphenated (`career-plan.md`); source files carry a date prefix (`2026-08-11-interview-a.md`).
9. **Cross-area topics are never duplicated**: they live only in `03-Projects/`, soft-linked via frontmatter `area: [...]`.
10. **Privacy**: interviewees, unpublished data, and others' manuscripts never enter cloud-model context; context documents describe structure and method only.

## 3. Area routing table

| Area | Context file | Trigger keywords |
|---|---|---|
<!-- area-rows-start -->
| side-hustle | [[02-Areas/side-hustle/_context]] | side hustle, monetization, topic, course |
| investing | [[02-Areas/investing/_context]] | portfolio, valuation, compounding |
| tech | [[02-Areas/tech/_context]] | architecture, performance, code |
| education | [[02-Areas/education/_context]] | course, reading, learning |
| health | [[02-Areas/health/_context]] | sleep, training, diet |
<!-- area-rows-end -->

## 4. Daily workflow

- **Start a project**: create under `03-Projects/` (initialize `_brief.md` from [[00-System/templates/tpl-project-brief]]) → link it in [[_INDEX]].
- **Gather sources**: clippings/interviews/sparks go to `10-source/` (clippings/ interviews/ sparks/), with timestamps and `source:` URLs.
- **Collect & distill**: cross-project third-party articles go to `04-Resources/clippings/` (`/intake/clip` stages, human moves them in); area judgments go to `02-Areas/` (`/knowledge/note` stages + paste-ready deltas; corrections are changelogs, never overwrites — mechanism in GUIDE.md §4.12).
- **Process**: read `10-source/` into summary cards in `20-notes/`, each linking back to its source.
- **Co-write**: read `_brief.md` + `challenges.md` → draft to `30-drafts/vN/` + baseline copy → after major human edits, analyze the editing patterns into that project's `20-notes/voice-update-<date>.md`; the human reviews and merges into `04-Resources/voice-reference.md` (AI never writes `04-Resources/` directly).
- **Finalize**: `50-final/` (`human_locked: true`) → copy to `60-published/` → record blockers in `journal.md` → when the project ends, move it into `05-Archive/YYYY/`.

## 5. Configuration index

- Permission enforcement: `.claude/settings.json` (deny → ask → allow; deny wins)
- MCP boundary: `.mcp.json` (vault-read full read-only / project-rw pinned to 03-Projects); on Linux/macOS overwrite it with `.mcp.linux.json` (fill paths, rename)
- Slash commands: `.claude/commands/` in five functional groups — `/intake/` (collect, clip, triage); `/produce/` (new, digest, draft, iterate, brief, archive); `/knowledge/` (note); `/quality/` (factcheck, voice); `/query/` (search, status). Command map in GUIDE.md §5.5
- Deterministic scripts: `00-System/scripts/` (status.sh, new-project.sh, archive-project.sh) — mechanical operations (mkdir/move/stats/field-flips) always go through scripts (zero hallucination, zero tokens, runnable without a session); AI only handles the judgment steps
- Obsidian governance: `.obsidian-agentignore`, `.obsidian-agentprotected` (leave untouched — the AI cannot edit its own shackles; they only constrain writes going through Obsidian — external writes rely on MCP and deny rules)
- Boards: `00-System/bases/drafts-board.base`, `00-System/bases/my-turn.base`, `00-System/bases/ai-audit.base` (`.base` files are not notes — open by path, not wikilink)
- Templates: `00-System/templates/`
