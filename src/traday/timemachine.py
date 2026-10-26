# Source code is private. This file shows only its classes and function signatures.

"""Time Machine: replay the rest of today thousands of times from a stock's own candles.

For each remaining 5-minute slot of the day (10:15, 10:20, ... 15:55) we draw that
same slot from a random past session and apply its move (high, low and close,
relative to the previous close) to the simulated price. Doing this 10,000 times
gives the odds that the target is touched before the stop, and where the stock
closes. Same-slot sampling keeps the shape of a real day: busy open, quiet lunch,
active close.

It is a resampling of the last ~60 sessions, not a forecast. News, earnings and
regime changes are not in it.
"""
from __future__ import annotations
import random
from bisect import bisect_left
from dataclasses import dataclass, field
from datetime import date, datetime, time
from . import clock
from .data import Candle


@dataclass
class ReplayResult:
    symbol: str
    entry: float
    stop: float
    target: float
    start: time
    sims: int
    sessions_used: int
    target_first: int
    stop_first: int
    neither: int
    green: int
    closes: list[float]

    def pct(self, n: int) -> float:
        ...

    def percentile(self, p: float) -> float:
        ...

    def histogram(self, bins: int=20) -> list[tuple[float, float, int]]:
        ...
Move = ...


def build_slots(history: dict[date, list[Candle]], interval_minutes: int=5) -> dict[int, list[Move]]:
    ...


def replay(symbol: str, entry: float, stop: float, target: float, start: datetime | time, history: dict[date, list[Candle]], sims: int=10000, seed: int | None=None, interval_minutes: int=5) -> ReplayResult:
    """Replay from `start` (the entry time) to the close, `sims` times."""
    ...
