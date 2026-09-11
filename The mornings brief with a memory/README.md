# Morning Brief with Memory

A small, scheduled loop that produces a short "morning brief" about this
repository once per run, using [`progress.md`](progress.md) as its **persistent
memory / spine**.

Each run is *stateless* — it remembers nothing on its own. `progress.md` is the
only thing that carries knowledge from one run to the next, so every run reads
it first and only reports what is **genuinely new** since last time.

## How a run works

1. **Read memory first** — open `progress.md`. Create it from a template if missing.
2. **Inspect the repo** — collect simple progress signals from one preferred source:
   - (a) open `TODO` comments in source files, or
   - (b) commits from the last 24h (only if it's a git repo and (a) found nothing).
3. **Compare** — a finding is *new* only if it isn't already in the
   `## Known findings` ledger in `progress.md`.
4. **Write the morning brief** — date/time, new findings, what was already known,
   and a short "Next focus". If nothing is new it says exactly:
   `No new progress since the previous run.`
5. **Update `progress.md`** — append new findings to the ledger and append the
   full brief to the run history. History is **never deleted**.

## Files

| Path | Role |
| --- | --- |
| `progress.md` | Persistent memory/spine + full run history (created by the first run). |
| `src/` | Sample source code that the loop scans for `TODO` comments. |
| `~/.claude/scheduled-tasks/morning-brief/SKILL.md` | The self-contained scheduled prompt. |

## Schedule

Runs unattended once per day at ~08:07 local time (cron `7 8 * * *`) via the
scheduled-tasks system. It also runs on next app launch if the machine was off
when it was due. Nothing needs to decide *when* to run — the scheduler does.
