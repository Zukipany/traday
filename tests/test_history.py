# Source code is private. This file shows only its classes and function signatures.

import tempfile
import unittest
from pathlib import Path
from helpers import REEL_DAY, FixedData, SimClock, reel_tsla
from traday import clock, history
from traday.brokers.paper import PaperBroker
from traday.config import Config, PaperConfig, RiskConfig
from traday.engine import Engine
from traday.journal import Journal
from traday.notify import Notifier
EARLIER = ...


def row(event, day, hhmm, **kw):
    ...


class HistoryTest(unittest.TestCase):

    def test_buys_and_sells_pair_into_trades_with_profit(self):
        ...

    def test_a_sell_whose_buy_is_older_than_the_window(self):
        ...

    def test_the_engines_own_journal(self):
        ...


if __name__ == '__main__':
    ...
