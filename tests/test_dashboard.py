# Source code is private. This file shows only its classes and function signatures.

import json
import tempfile
import threading
import unittest
import urllib.error
import urllib.request
from http.server import ThreadingHTTPServer
from pathlib import Path
from helpers import REEL_DAY, FixedData, SimClock, reel_tsla
from traday import clock
from traday.config import Config
from traday.dashboard import App, ReplayClock, World, make_handler
from traday.data import SyntheticData
from traday.engine import BotLock


def config(state_dir: Path, watch=('TSLA',)) -> Config:
    ...


class WorldTest(unittest.TestCase):

    def setUp(self):
        ...

    def test_scan_and_chart_show_the_reel_trade(self):
        ...

    def test_chart_never_shows_an_exit_for_a_trade_still_open(self):
        ...

    def test_status_and_kill_switch(self):
        ...

    def test_replay_needs_a_breakout_or_levels(self):
        ...

    def test_live_config_never_starts_from_the_page(self):
        ...


class LockAndStopTest(unittest.TestCase):

    def test_one_bot_per_folder(self):
        ...

    def test_replay_clock_runs_fast_and_stops_at_the_end(self):
        ...


class HttpTest(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        ...

    @classmethod
    def tearDownClass(cls):
        ...

    def call(self, path, post=False, headers=None, data=None):
        ...

    def test_page_and_api(self):
        ...

    def test_settings_over_http(self):
        ...

    def test_posts_need_the_header_and_a_local_host(self):
        ...


if __name__ == '__main__':
    ...


class FakeDegiro:
    """Stands in for DegiroBroker: logs in, reports an account, records orders."""
    name = ...

    def __init__(self, live: bool):
        ...

    def snapshot(self):
        ...

    def search(self, text, limit=10):
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


class LiveControlTest(unittest.TestCase):
    """Everything the page can change: settings, DEGIRO login, paper/live, the live bot, closing trades."""

    def setUp(self):
        ...

    def restore_env(self):
        ...

    def test_settings_are_checked_saved_and_reloaded(self):
        ...

    def test_credentials_are_saved_privately_and_never_returned(self):
        ...

    def test_real_money_needs_a_tested_login_and_typing_live(self):
        ...

    def test_close_now_while_the_bot_is_stopped(self):
        ...

    def test_alert_test_and_paper_reset(self):
        ...
