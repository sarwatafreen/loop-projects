#!/usr/bin/env bash
# long_task.sh — simulate a long-running job, then write a done-marker file.
# Usage: bash long_task.sh [DURATION_SECONDS]   (default 120)
set -euo pipefail

DURATION="${1:-120}"                       # how long to "work", in seconds
OUTDIR="$(cd "$(dirname "$0")" && pwd)"    # project dir (where this script lives)
DONE_FILE="$OUTDIR/task_done.txt"

# Start fresh so a re-run doesn't leave a stale marker the watcher would trip on.
rm -f "$DONE_FILE"

START="$(date '+%Y-%m-%d %H:%M:%S')"
echo "[long_task] started at $START, will run for ${DURATION}s"

sleep "$DURATION"

END="$(date '+%Y-%m-%d %H:%M:%S')"
{
  echo "Task finished!"
  echo "started:  $START"
  echo "finished: $END"
  echo "ran for:  ${DURATION}s"
} > "$DONE_FILE"

echo "[long_task] finished at $END, wrote $DONE_FILE"
