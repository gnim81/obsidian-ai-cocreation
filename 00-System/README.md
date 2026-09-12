# 00-System — Governance layer

The vault's system configuration. AI read-only by default.

## Contents

| Path | Purpose |
|---|---|
| `templates/` | Frontmatter templates: project brief, source, note card, draft |
| `bases/` | Bases boards: drafts-board / my-turn / ai-audit |
| `scripts/` | Deterministic bash scripts: status.sh, new-project.sh, archive-project.sh |

## Templates

1. Enable the core **Templates** plugin (its folder is preconfigured to `00-System/templates` via `.obsidian/templates.json`).
2. Create a note, then run "Insert template" from the command palette; `{{date:YYYY-MM-DD}}` placeholders are filled automatically.
3. Note: don't insert a template into a note that already has frontmatter — you'd end up with two blocks.

## Bases boards (Obsidian 1.9+ built-in)

- **drafts-board**: filters `type == "draft"` within `03-Projects/`, grouped by `status` (install a Kanban Bases View plugin to drag cards between statuses).
- **my-turn**: filters `status == "revising"`, with a `stale` formula column (days since last change) to surface stalled drafts.
- **ai-audit**: files carrying `authored_by` — for post-hoc fact-check triage.

> All three boards use `file.inFolder("03-Projects")` to exclude the templates themselves. If your Obsidian version reports a syntax error, delete the offending filter line — nothing else breaks.
