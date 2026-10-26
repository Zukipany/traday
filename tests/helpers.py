# Source code is private. This file shows only its classes and function signatures.

"""Builders shared by the tests: candles for the reel's TSLA day, fake data, fake clock."""
from __future__ import annotations
from datetime import date, datetime, timedelta
from traday import clock
from traday.data import Candle
REEL_DAY = ...


def bar(hhmm: str, o: float, h: float, l: float, c: float, day: date=REEL_DAY, v: float=1000000.0) -> Candle:
    ...


def flat_bars(start: str, end: str, price: float, day: date=REEL_DAY, spread: float=0.5) -> list[Candle]:
    ...


def reel_tsla(day: date=REEL_DAY, after: str='target') -> list[Candle]:
    """Range 354.47-362.18, the 10:10 candle closes at 364.18, then `after` happens."""
    ...


class SimClock:

    def __init__(self, start: datetime):
        ...

    def __call__(self) -> datetime:
        ...

    def sleep(self, seconds: float) -> None:
        ...


class FixedData:
    """Serves fixed candles, showing only those finished by the clock's time."""

    def __init__(self, candles: dict[str, list[Candle]], now_fn):
        ...

    def intraday(self, symbol, days=1, interval_minutes=5):
        ...
