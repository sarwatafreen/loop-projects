"""
mathutils.py -- small math helpers.

Final, correct implementation. Correctness is verified by the test runner
via run_loop.sh -- the test command is the source of truth.
"""


def add(a, b):
    """Return the sum of a and b."""
    return a + b


def is_even(n):
    """Return True if n is even."""
    return n % 2 == 0


def factorial(n):
    """Return n! = 1 * 2 * ... * n (with 0! == 1)."""
    result = 1
    for i in range(2, n + 1):
        result *= i
    return result
