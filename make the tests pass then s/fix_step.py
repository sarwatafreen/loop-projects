"""
fix_step.py -- the "keep working on the code" step of the loop.

Called by run_loop.sh after a FAILING test run.  It fixes exactly ONE
remaining defect in mathutils.py and then returns, so the loop needs several
passes to reach green -- demonstrating a genuine multi-attempt conditional loop.

IMPORTANT: this script only ever edits the IMPLEMENTATION (mathutils.py).
It never touches the tests.  It also never decides that the work is finished --
only the test runner does that.
"""

import sys

PATH = "mathutils.py"

# (buggy snippet, corrected snippet, human-readable label)
# Applied top-to-bottom, ONE per invocation.
FIXES = [
    (
        "    return a - b\n",
        "    return a + b\n",
        "add(): use + instead of -",
    ),
    (
        "    return n % 2 == 1\n",
        "    return n % 2 == 0\n",
        "is_even(): a number is even when n % 2 == 0",
    ),
    (
        "    return 0\n",
        "    result = 1\n"
        "    for i in range(2, n + 1):\n"
        "        result *= i\n"
        "    return result\n",
        "factorial(): compute the real product 1*2*...*n",
    ),
]


def main():
    with open(PATH, "r", encoding="utf-8") as f:
        src = f.read()

    for buggy, fixed, label in FIXES:
        if buggy in src:
            src = src.replace(buggy, fixed, 1)
            with open(PATH, "w", encoding="utf-8") as f:
                f.write(src)
            print(f"   [fix_step] fixed one defect -> {label}")
            return 0

    print("   [fix_step] no known defect left to fix")
    return 0


if __name__ == "__main__":
    sys.exit(main())
