#!/usr/bin/env bash
#
# run_loop.sh -- Conditional test-fix loop.
#
# Contract:
#   - Run the TEST COMMAND.
#   - Read the test runner's EXIT STATUS. That exit status is the ONLY
#     source of truth for whether the work is done.
#   - If tests PASS (exit 0) -> stop IMMEDIATELY and report SUCCESS.
#   - If tests FAIL           -> (optionally) run the fix step, then loop again.
#   - Try at most MAX_ATTEMPTS times.
#   - If still failing after MAX_ATTEMPTS -> stop and report the CAP was hit.
#
# The loop -- not the agent -- decides when to stop, and it decides purely
# from the test runner's exit code.  The tests are never modified.

set -u

TEST_CMD="python -m unittest -v test_mathutils"
MAX_ATTEMPTS=6
AUTOFIX="${AUTOFIX:-1}"     # 1 = run the fix step between failures, 0 = leave code untouched

echo "=================================================================="
echo " Conditional test-fix loop"
echo " Test command : $TEST_CMD"
echo " Max attempts : $MAX_ATTEMPTS"
echo " Auto-fix     : $AUTOFIX   (1 = fix between failures, 0 = off)"
echo "=================================================================="

attempt=1
passed=0

# Conditional loop: keep going WHILE tests fail AND attempts remain.
while [ "$attempt" -le "$MAX_ATTEMPTS" ]; do
    echo
    echo "------------------- Attempt $attempt of $MAX_ATTEMPTS -------------------"

    # Run the test command and capture its exit status (the source of truth).
    if $TEST_CMD; then
        status=0
    else
        status=$?
    fi

    if [ "$status" -eq 0 ]; then
        echo ">> Attempt $attempt RESULT: PASS  (test runner exit status = 0)"
        passed=1
        break                      # requirement 7 & 10: pass -> stop immediately
    fi

    echo ">> Attempt $attempt RESULT: FAIL  (test runner exit status = $status)"

    if [ "$AUTOFIX" -eq 1 ]; then
        echo ">> Tests still failing -- continuing to work on the code (fix step):"
        python fix_step.py
    else
        echo ">> Auto-fix disabled -- code left unchanged for this demo."
    fi

    attempt=$((attempt + 1))
done

echo
echo "=================================================================="
if [ "$passed" -eq 1 ]; then
    echo "FINAL RESULT: SUCCESS"
    echo "The loop STOPPED because the TEST COMMAND PASSED on attempt $attempt."
    echo "Attempt $attempt of $MAX_ATTEMPTS -- the maximum was NOT reached."
    echo "=================================================================="
    exit 0
else
    echo "FINAL RESULT: STOPPED -- MAXIMUM ATTEMPTS REACHED"
    echo "Ran the maximum of $MAX_ATTEMPTS attempts and the tests are STILL"
    echo "FAILING. Stopping as required. No tests were modified."
    echo "=================================================================="
    exit 1
fi
