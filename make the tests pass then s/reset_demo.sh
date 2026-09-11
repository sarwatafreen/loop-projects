#!/usr/bin/env bash
#
# reset_demo.sh -- put mathutils.py into a deliberately BROKEN state so the
# loop can be demonstrated starting from red.  Three real bugs, one per
# function.  The tests are never touched.

cat > mathutils.py <<'PY'
"""mathutils.py -- deliberately broken starting point for the loop demo."""


def add(a, b):
    return a - b


def is_even(n):
    return n % 2 == 1


def factorial(n):
    return 0
PY

echo "[reset_demo] wrote a broken mathutils.py (3 real bugs: add, is_even, factorial)"
