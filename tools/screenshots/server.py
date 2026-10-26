# Source code is private. This file shows only its classes and function signatures.

"""A dashboard to take README screenshots of: the real code, made-up prices, a frozen clock.

    python tools/screenshots/server.py                        # paper account, http://127.0.0.1:8790
    python tools/screenshots/server.py --live --port 8791     # a pretend DEGIRO account (nothing real)

It plays the 5 sessions before the last finished US session (--history), then that session from
9:29 to 10:32 New York time (--at), through the real engine (synthetic prices, a paper or pretend-DEGIRO broker), then serves the dashboard frozen there
with that day's trades, journal and an "on" phone access with a made-up pairing code. Nothing
touches the internet, your traday.toml, .env or state folder: it all lives in a temp folder.
`shoot.mjs` takes the pictures.
"""
from __future__ import annotations
import argparse
import json
import os
import sys
import tempfile
import threading
from datetime import timedelta
from http.server import ThreadingHTTPServer
from pathlib import Path
from traday import clock, news
_at = ...
DAY = ...
FROZEN = ...
from traday.brokers.base import OrderResult, Position
from traday.brokers.paper import PaperBroker
from traday.config import Config, save_config
from traday.dashboard import App, make_handler
from traday.data import SyntheticData
from traday.engine import Engine
from traday.journal import Journal
from traday.notify import Notifier
from traday.remote import TOKEN_KEY, Tailscale
FAKE_CODE = ...
FAKE_HOST = ...


class PretendDegiro:
    """Stands in for DEGIRO: a made-up account that fills every order at the asked price."""
    name = ...
    live = ...

    def __init__(self):
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


def fake_tailscale(args, timeout):
    """`tailscale` as if phone access were on (made-up names, nothing is run)."""
    ...


def main() -> None:
    ...
PORT = ...


if __name__ == '__main__':
    ...
