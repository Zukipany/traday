# Source code is private. This file shows only its classes and function signatures.

"""Dashboard: a page in your browser for the scanner, charts, Time Machine and the bot.

    traday dashboard            # opens http://127.0.0.1:8765
    traday dashboard --demo     # start on the demo view
    traday dashboard --bot      # also start the paper bot right away (for auto-start setups)

Two views, switchable on the page:
  live  real prices (Yahoo), your paper or DEGIRO account, the bot, settings, DEGIRO login
  demo  the last finished session replayed at 60x with made-up prices and its own paper bot

The server only listens on this computer (127.0.0.1). Everything is controllable from the
page, including real-money trading on DEGIRO, but anything real-money (switching to live,
starting the live bot) needs you to type LIVE first. Passwords are never sent back to the page.

Phones reach it through `tailscale serve` (see remote.py): those requests arrive with a
*.ts.net host name and must carry the pairing code. A paired phone can do everything the page
can, except change the DEGIRO login or the phone access itself.
"""
from __future__ import annotations
import copy
import importlib.util
import json
import logging
import os
import shutil
import threading
import time
import webbrowser
from dataclasses import asdict
from datetime import date, datetime, timedelta
from http.cookies import CookieError, SimpleCookie
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import parse_qs, urlparse
from . import agents, clock, history, news, strategy, timemachine
from .brokers.paper import PaperBroker
from .config import Config, ConfigError, config_from_dict, config_path, config_to_dict, env_path, save_config, save_env
from .data import DataError, SyntheticData, YahooData, by_session, completed
from .engine import BotLock, Engine, load_day_state
from .journal import Journal
from .notify import Notifier
from .remote import COOKIE, RemoteAccess
WEB = ...
PAGE = ...
PAIR_PAGE = ...
AGENTS_PAGE = ...
STATIC = ...
LOCAL_HOSTS = ...
PROXY_HEADERS = ...
LOCAL_ONLY = ...
DEMO_START = ...
DEMO_END = ...
log = ...


class ReplayClock:
    """A past session played back at `speed` x real time."""

    def __init__(self, start: datetime, speed: float=60.0, end: datetime | None=None):
        ...

    def reset(self, start: datetime, speed: float | None=None) -> None:
        ...

    def __call__(self) -> datetime:
        ...

    def set_speed(self, speed: float) -> None:
        ...


class CachedData:
    """Keeps answers for a few seconds so a busy page does not hammer Yahoo."""

    def __init__(self, inner, ttl: float=20.0):
        ...

    def intraday(self, symbol: str, days: int=1, interval_minutes: int=5):
        ...


def _range(r: strategy.OpeningRange | None) -> dict | None:
    ...


def _plan(p: strategy.TradePlan | None) -> dict | None:
    ...


def _exit(e: strategy.Exit | None) -> dict | None:
    ...


class DegiroLink:
    """The dashboard's own read-only DEGIRO connection: set up? working? what is in the account?"""
    KEYS = ...

    def __init__(self, world: 'World', factory=None):
        ...

    @staticmethod
    def configured() -> bool:
        ...

    @staticmethod
    def source() -> str:
        ...

    def reset(self) -> None:
        ...

    def _make(self, live: bool):
        ...

    def broker(self):
        ...

    def summary(self, force: bool=False, max_age: float=30.0) -> dict | None:
        ...

    def public(self) -> dict:
        ...


class BotRunner:
    """Runs the autopilot (paper, or DEGIRO after you type LIVE) in a background thread."""

    def __init__(self, world: 'World'):
        ...

    @property
    def running(self) -> bool:
        ...

    def live(self) -> bool:
        ...

    def can_start(self) -> tuple[bool, str]:
        ...

    def _sleep(self, seconds: float) -> None:
        ...

    def poke(self) -> None:
        """Wake the loop now (used after queuing a command)."""
        ...

    def make_engine(self, live: bool, broker=None) -> Engine:
        ...

    def start(self, confirm: str | None=None) -> None:
        ...

    def stop(self, wait: float=10.0) -> None:
        ...

    def info(self) -> dict:
        ...


class World:
    """Everything one view of the page needs: data, clock, state folder, bot."""

    def __init__(self, name: str, cfg: Config, state_dir: Path, data, now_fn, demo: bool=False, demo_day: date | None=None, replay_clock: ReplayClock | None=None, degiro_factory=None):
        ...

    def speed(self) -> float:
        ...

    def now(self) -> datetime:
        ...

    def session_day(self) -> tuple[date, datetime | None, bool]:
        """(day to show, the time to judge it at or None for a finished day, is it running now)."""
        ...

    def candles(self, symbol: str, day: date, judge_at: datetime | None, forming: bool=False):
        ...

    def account(self) -> dict:
        ...

    def status(self) -> dict:
        ...

    def scan(self) -> dict:
        ...

    def chart(self, symbol: str) -> dict:
        ...

    def replay(self, symbol: str, q: dict) -> dict:
        ...

    def journal(self, days: int=1) -> list[dict]:
        ...

    def trades(self, days: int=30) -> dict:
        """Every buy and sell of the last `days` days, paired into trades with their profit."""
        ...

    def headlines(self) -> dict:
        ...

    def close_trade(self, symbol: str | None) -> dict:
        """Sell one open trade (or all of them with None) at market, now."""
        ...

    def kill(self, on: bool) -> None:
        ...


class App:

    def __init__(self, cfg: Config, speed: float=60.0, config_file: str | Path | None=None, data=None, degiro_factory=None, tailscale=None):
        ...

    def world(self, name: str) -> World:
        ...

    def _make_demo(self) -> World:
        ...

    def restart_demo(self) -> None:
        ...

    def shutdown(self) -> None:
        ...

    def agents_page(self, world: World) -> dict:
        """The agents page: who they are (with your settings), what each is doing now, and the setup checks."""
        ...

    def agents_setup(self, alerts: dict) -> dict:
        """Quick-setup checks for connecting the trading platform (never any secret)."""
        ...

    def agents_story(self) -> dict:
        """The reel's TSLA trade told by the agents, with your settings (cached until they change)."""
        ...

    def settings(self) -> dict:
        ...

    def save_settings(self, body: dict) -> dict:
        ...

    def save_credentials(self, body: dict) -> dict:
        ...

    def test_degiro(self) -> dict:
        ...

    def set_mode(self, body: dict) -> dict:
        ...

    def test_alert(self) -> dict:
        ...

    def paper_reset(self) -> dict:
        ...

    def degiro_search(self, text: str) -> list[dict]:
        ...

    def remote_status(self, port: int) -> dict:
        ...

    def remote_switch(self, on: bool, port: int) -> dict:
        ...

    def remote_new_code(self, port: int) -> dict:
        ...


def live_journal(world: World, event: str, **data) -> None:
    ...


def _device(agent: str) -> str:
    ...


def make_handler(app: App):
    ...


def serve(cfg: Config, port: int=8765, open_browser: bool=True, view: str='live', speed: float=60.0, start_bot: bool=False, config_file: str | Path | None=None) -> None:
    ...
