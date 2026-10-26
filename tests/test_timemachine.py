# Source code is private. This file shows only its classes and function signatures.

import unittest
from datetime import date, timedelta
from helpers import flat_bars
from traday import clock, timemachine
from traday.data import Candle


def trending(day: date, step: float) -> list[Candle]:
    ...


def history(step: float, days: int=10) -> dict:
    ...


class ReplayTest(unittest.TestCase):

    def test_uptrend_hits_target(self):
        ...

    def test_downtrend_hits_stop(self):
        ...

    def test_outcomes_add_up_and_are_reproducible(self):
        ...

    def test_rejects_bad_levels(self):
        ...


if __name__ == '__main__':
    ...
