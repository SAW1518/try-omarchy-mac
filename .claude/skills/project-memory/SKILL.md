---
name: project-memory
description: Memory for the omarchy-mac project, kept INSIDE the project (memory/ folder), never in ~/.claude or anywhere else. Use it when starting a task to recall (verified versions, decisions, problems already solved) and whenever you learn something worth keeping - a user decision, a correction about how to work, a verified Omarchy version, a problem and its fix - or when the user says "remember", "save this", "forget" (or in Spanish "recuerda", "acuérdate", "guarda esto", "olvida").
---

# Project memory

Memory lives in `memory/`, next to this project (in the `~/bypass` shared folder, so both the Mac and the VM see it).
**Never write memory anywhere else**: not in `~/.claude/projects/*/memory/`, not in `~/.claude/CLAUDE.md`, not in external services. Claude Code's auto memory is turned off in `.claude/settings.json` for that reason.

## Layout

- `memory/MEMORY.md`: the index. It is loaded into every session from `CLAUDE.md`. One line per memory: `- [Title](file.md) — what it's about`. Never put the content itself here.
- `memory/<topic>.md`: one file per topic, in this format:

```markdown
---
name: <lowercase-slug>
description: <one line, used to decide relevance>
type: user | feedback | project | reference
updated: YYYY-MM-DD
---

<the fact. For feedback and project, add **Why:** and **How to apply:**. Link other memories with [[slug]].>
```

## Recall

At the start, `MEMORY.md` is already in context. Read only the files related to the task. Memories were true when written: if one names a file, command or version, **verify it** before relying on it. Omarchy edge changes often.

## Save

1. Check for an existing file on the topic (`grep -ril <word> memory/`). If there is one, **update it** and its `updated` date; don't create a duplicate.
2. Otherwise create `memory/<slug>.md` and add its line to `MEMORY.md`.
3. Use absolute dates (2026-10-27, not "today" or "yesterday").
4. If a memory turns out to be wrong, fix or delete it, and remove its index line.
5. Write memories in English (the user reads and talks in Spanish, but the project files are in English).

## What to save and what not

- **Yes:** user decisions and their reasons; corrections about how to work with the user; the Omarchy/Try Omarchy version that was verified; problems found and how they were solved; facts about the hardware (keyboard, Mac).
- **No:** what the code or script already says; details that only matter to today's conversation; passwords, tokens or anything private (names, emails, usernames, personal paths); nothing about the user's job.
- **This project is published to git.** Write every memory as if it were public.
