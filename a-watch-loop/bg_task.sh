#!/usr/bin/env bash
# bg_task.sh — a tracked 10-minute background task.
# Writes task_status.txt every 30s with a timestamp + RUNNING,
# then writes DONE and creates task_done.txt at the end.
# Run this via the harness background-task mechanism (run_in_background),
# NOT with nohup/&/setsid — it is meant to block in the foreground for 10 min.
set -euo pipefail

OUTDIR="$(cd "$(dirname "$0")" && pwd)"
STATUS="$OUTDIR/task_status.txt"
DONE="$OUTDIR/task_done.txt"

DURATION=600      # total run time: 10 minutes
INTERVAL=30       # heartbeat cadence: 30 seconds

# Fresh start.
rm -f "$DONE"

START="$(date '+%Y-%m-%d %H:%M:%S')"
elapsed=0
echo "$(date '+%Y-%m-%d %H:%M:%S') RUNNING  (elapsed ${elapsed}s / ${DURATION}s, pid $$)" > "$STATUS"

while [ "$elapsed" -lt "$DURATION" ]; do
  sleep "$INTERVAL"
  elapsed=$((elapsed + INTERVAL))
  if [ "$elapsed" -lt "$DURATION" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') RUNNING  (elapsed ${elapsed}s / ${DURATION}s, pid $$)" > "$STATUS"
  fi
done

END="$(date '+%Y-%m-%d %H:%M:%S')"
echo "$END DONE  (ran ${DURATION}s, started $START, pid $$)" > "$STATUS"
{
  echo "Task finished!"
  echo "started:  $START"
  echo "finished: $END"
  echo "ran for:  ${DURATION}s"
} > "$DONE"
