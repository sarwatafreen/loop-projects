"""
Test suite for mathutils.  THIS FILE IS THE SOURCE OF TRUTH.

The rules of this project forbid faking, skipping, weakening, deleting, or
modifying these tests to make them pass.  The only way to go green is to make
the implementation in mathutils.py actually correct.

Run with:   python -m unittest -v test_mathutils
"""

import unittest

from mathutils import add, is_even, factorial


class TestMathUtils(unittest.TestCase):
    def test_add(self):
        self.assertEqual(add(2, 3), 5)
        self.assertEqual(add(-1, 1), 0)
        self.assertEqual(add(0, 0), 0)

    def test_is_even(self):
        self.assertTrue(is_even(4))
        self.assertTrue(is_even(0))
        self.assertFalse(is_even(7))

    def test_factorial(self):
        self.assertEqual(factorial(0), 1)
        self.assertEqual(factorial(1), 1)
        self.assertEqual(factorial(5), 120)


if __name__ == "__main__":
    unittest.main()
