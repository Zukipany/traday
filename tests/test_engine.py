# Source code is private. This file shows only its classes and function signatures.

import tempfile
import unittest
from pathlib import Path
from helpers import REEL_DAY, FixedData, SimClock, reel_tsla
from traday import clock
from traday.brokers.base import OrderResult, Position
from traday.brokers.paper import PaperBroker
from traday.config import Config, PaperConfig, RiskConfig
from traday.engine import Engine
from traday.journal import Journal
from traday.notify import Notifier


def config() -> Config:
    ...


class FakeLiveBroker:
    """Stands in for DEGIRO: fills at the reference price and records every call."""
    name = ...
    live = ...

    def __init__(self):
        ...

    def cash(self):
        ...

    def positions(self):
        ...

    def buy(self, symbol, qty, limit_price, ref_price):
        ...

    def sell(self, symbol, qty, ref_price, limit_price=None):
        ...

    def place_stop(self, symbol, qty, stop_price):
        ...

    def cancel(self, order_id):
        ...


class EngineTest(unittest.TestCase):

    def make(self, after='target', start='09:25', broker=None):
        ...

    def events(self, name):
        ...

    def test_paper_day_hits_target(self):
        ...

    def test_paper_day_hits_stop(self):
        ...

    def test_flattens_at_end_of_day(self):
        ...

    def test_never_chases_an_old_breakout(self):
        ...

    def test_kill_switch_closes_and_blocks(self):
        ...

    def test_restart_resumes_the_open_trade(self):
        ...

    def test_trade_left_open_overnight_is_sold_at_the_next_open(self):
        ...

    def test_close_now_from_the_page(self):
        ...

    def test_stop_hook_ends_the_loop(self):
        ...

    def test_live_places_stop_and_cancels_it_at_target(self):
        ...

    def test_live_stop_filled_at_the_broker(self):
        ...


if __name__ == '__main__':
    ...
