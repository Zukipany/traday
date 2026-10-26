# Source code is private. This file shows only its classes and function signatures.

"""Autopilot: runs a trading day on its own, on paper or on DEGIRO.

Every `poll_seconds` during market hours:
  1. manage open trades: exit at the target or the stop (live: the stop also rests
     at DEGIRO as a real stop-loss order, so it works even if this program dies)
  2. after the opening range, look for a fresh breakout on each watchlist stock
  3. risk-check it, size it, buy it, place the protective stop, alert you
  4. at `flatten_at` (or when the kill switch file exists) close everything
State lives in state/day-YYYY-MM-DD.json, so a restart picks up where it left off.
"""
from __future__ import annotations
import json
import logging
import os
import queue
import time as _time
from datetime import datetime, timedelta
from pathlib import Path
from typing import Callable
from . import clock, news, risk, strategy
from .brokers.base import Broker
from .config import Config
from .data import DataError, DataSource, completed
from .journal import Journal
from .notify import Notifier
log = ...


def load_day_state(state_dir: Path, day) -> dict:
    ...


class BotLock:
    """Only one autopilot per state folder: two would fight over the same trades.

    An OS file lock, so it disappears by itself if the process dies.
    """

    def __init__(self, state_dir: Path):
        ...

    def acquire(self) -> bool:
        ...

    def release(self) -> None:
        ...


class Engine:

    def __init__(self, cfg: Config, data: DataSource, broker: Broker, notifier: Notifier, journal: Journal, now_fn: Callable[[], datetime]=clock.now_et, sleep_fn: Callable[[float], None]=_time.sleep, news_fetcher: Callable | None=news.fetch, state_dir: Path | None=None):
        ...

    @property
    def kill_path(self) -> Path:
        ...

    def killed(self) -> bool:
        ...

    def _state_path(self, day) -> Path:
        ...

    def load_state(self, day) -> dict:
        ...

    def _save_state(self, st: dict) -> None:
        ...

    @property
    def mode(self) -> str:
        ...

    def run(self, once: bool=False, until: datetime | None=None, should_stop: Callable[[], bool] | None=None) -> str:
        ...

    def tick(self) -> str:
        ...

    def request(self, command: str, symbol: str | None=None) -> None:
        """Ask the running loop to do something on its next pass: "close" one trade or "close-all"."""
        ...

    def run_commands(self) -> None:
        """Do the queued commands now, without scanning for entries (used when the bot is stopped)."""
        ...

    def _process_commands(self, st: dict, now: datetime) -> None:
        ...

    def _today(self, symbol: str, now: datetime, only_completed: bool) -> list:
        ...

    def _scan(self, st: dict, now: datetime, open_: datetime) -> None:
        ...

    def _enter(self, st: dict, plan: strategy.TradePlan, now: datetime) -> None:
        ...

    def _plan_of(self, t: dict) -> strategy.TradePlan:
        ...

    def _manage_open(self, st: dict, now: datetime) -> None:
        ...

    def _last_price(self, sym: str, now: datetime, fallback: float) -> float:
        ...

    def _flatten(self, st: dict, now: datetime, reason: str) -> None:
        ...

    def _close(self, st: dict, t: dict, price: float, reason: str, now: datetime, already_closed: bool=False) -> None:
        ...

    def _summary(self, st: dict, now: datetime) -> None:
        ...

    def _carry_over(self, st: dict, now: datetime) -> None:
        """Trades left open on an earlier day (the computer was off at the close) are sold at this open."""
        ...

    def _reconcile(self, st: dict) -> None:
        ...

    def _check_news(self, st: dict, now: datetime, hours: float) -> None:
        ...
