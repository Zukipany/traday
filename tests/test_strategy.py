# Source code is private. This file shows only its classes and function signatures.

import unittest
from datetime import timedelta
from helpers import REEL_DAY, bar, flat_bars, reel_tsla
from traday import clock, strategy
from traday.config import StrategyConfig


class ReelTradeTest(unittest.TestCase):
    """The reel's TSLA numbers come out of the rules exactly."""

    def test_plan_matches_the_reel(self):
        ...

    def test_range_low_stop(self):
        ...

    def test_exits(self):
        ...


class StatusTest(unittest.TestCase):

    def test_building_then_watching_then_expired(self):
        ...

    def test_range_filters(self):
        ...

    def test_no_entry_after_cutoff(self):
        ...


class FirstTouchTest(unittest.TestCase):

    def setUp(self):
        ...

    def test_candle_spanning_both_counts_as_stop(self):
        ...

    def test_gap_fills_at_the_open(self):
        ...

    def test_ignores_candles_before_entry(self):
        ...


class BacktestTest(unittest.TestCase):

    def test_counts(self):
        ...


if __name__ == '__main__':
    ...
