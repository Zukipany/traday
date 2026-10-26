# Source code is private. This file shows only its classes and function signatures.

"""Market data: 5-minute candles from Yahoo, a CSV folder, or a synthetic generator."""
from __future__ import annotations
import csv
import json
import math
import random
import time as _time
import urllib.error
import urllib.parse
import urllib.request
from dataclasses import dataclass
from datetime import date, datetime, timedelta
from pathlib import Path
from typing import Callable, Protocol
from . import clock


class DataError(RuntimeError):
    ...


@dataclass(frozen=True)
class Candle:
    ts: datetime
    open: float
    high: float
    low: float
    close: float
    volume: float


class DataSource(Protocol):

    def intraday(self, symbol: str, days: int=1, interval_minutes: int=5) -> list[Candle]:
        """Regular-session candles for the last `days` sessions, oldest first.

        Today's last candle may still be forming; use `completed()` to drop it.
        """
        ...


def regular_hours(candles: list[Candle]) -> list[Candle]:
    ...


def completed(candles: list[Candle], now: datetime, interval_minutes: int=5) -> list[Candle]:
    ...


def by_session(candles: list[Candle]) -> dict[date, list[Candle]]:
    ...


def parse_yahoo_chart(payload: dict) -> list[Candle]:
    ...


class YahooData:
    """Yahoo Finance's chart endpoint. Free and unofficial: it can change or rate-limit.

    5-minute candles go back about 60 days, which is what the Time Machine replays.
    """
    BASE = ...
    HEADERS = ...

    def __init__(self, timeout: float=15.0, history_ttl: float=600.0):
        ...

    @staticmethod
    def _range(days: int) -> str:
        ...

    def _get(self, url: str) -> dict:
        ...

    def intraday(self, symbol: str, days: int=1, interval_minutes: int=5) -> list[Candle]:
        ...


class CsvData:
    """A folder of SYMBOL.csv files: ts,open,high,low,close,volume (ts in ISO format)."""

    def __init__(self, folder: str | Path):
        ...

    def intraday(self, symbol: str, days: int=1, interval_minutes: int=5) -> list[Candle]:
        ...
DEMO_PRICES = ...


class SyntheticData:
    """Deterministic random-walk candles for demos and tests. Not real prices.

    Each (seed, symbol, day) always produces the same session, and today's
    session only shows candles that have finished by `now_fn()`.
    """

    def __init__(self, now_fn: Callable[[], datetime]=clock.now_et, seed: int=0, bar_vol: float=0.0025):
        ...

    def _base(self, symbol: str) -> float:
        ...

    def session_candles(self, symbol: str, day: date, interval_minutes: int=5) -> list[Candle]:
        ...

    def intraday(self, symbol: str, days: int=1, interval_minutes: int=5) -> list[Candle]:
        ...
