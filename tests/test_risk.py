# Source code is private. This file shows only its classes and function signatures.

import unittest
from helpers import reel_tsla
from traday import risk, strategy
from traday.config import RiskConfig, StrategyConfig
PLAN = ...
OK = ...


class RiskTest(unittest.TestCase):

    def test_sizes_by_risk(self):
        ...

    def test_sizes_by_position_and_cash(self):
        ...

    def test_fees_can_block(self):
        ...

    def test_limits_block(self):
        ...

    def test_net_result_after_degiro_costs(self):
        ...


if __name__ == '__main__':
    ...
