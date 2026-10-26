# Source code is private. This file shows only its classes and function signatures.

"""Opening-range breakout: the scanner, entry timer and exit planner in one place.

The rules (all times New York):
  range   first `range_minutes` of the session (9:30-9:45 by default)
  entry   the first `interval_minutes` candle that CLOSES above the range high,
          before `entry_cutoff`; you buy at that close
  stop    the range midpoint (or the range low)
  target  entry + target_r x (entry - stop)
  exit    whichever of stop / target is touched first, else at `flatten_at`

The reel's TSLA example fits these rules exactly: range high 362.18, low 354.47,
the 10:10 candle closed at 364.18 -> entry 364.18, stop 358.32 (the midpoint),
target 370.04 (1R).
"""
from __future__ import annotations
import math
from dataclasses import dataclass
from datetime import date, datetime, timedelta
from . import clock
from .config import StrategyConfig
from .data import Candle
NO_DATA = ...
BUILDING = ...
TOO_NARROW = ...
TOO_WIDE = ...
WATCHING = ...
TRIGGERED = ...
EXPIRED = ...


@dataclass(frozen=True)
class OpeningRange:
    day: date
    high: float
    low: float
    end: datetime

    @property
    def mid(self) -> float:
        ...

    @property
    def width_pct(self) -> float:
        ...


@dataclass(frozen=True)
class TradePlan:
    symbol: str
    signal_time: datetime
    entry: float
    stop: float
    target: float
    range: OpeningRange

    @property
    def risk_per_share(self) -> float:
        ...

    @property
    def reward_per_share(self) -> float:
        ...


@dataclass(frozen=True)
class Setup:
    symbol: str
    status: str
    range: OpeningRange | None
    plan: TradePlan | None
    last: float | None


def opening_range(session_candles: list[Candle], cfg: StrategyConfig) -> OpeningRange | None:
    ...


def plan_for(symbol: str, entry: float, rng: OpeningRange, cfg: StrategyConfig, signal_time: datetime) -> TradePlan:
    ...


def evaluate(symbol: str, session_candles: list[Candle], cfg: StrategyConfig, now: datetime | None=None) -> Setup:
    """Where one stock stands today. Pass only candles that have finished."""
    ...


@dataclass(frozen=True)
class Exit:
    time: datetime
    price: float
    reason: str


def first_touch(plan: TradePlan, candles: list[Candle], interval_minutes: int=5) -> Exit | None:
    """The first candle after entry that reaches the stop or the target.

    If one candle spans both, the stop counts (we cannot know the order inside it).
    A candle that opens beyond a level fills at its open, like a real gap.
    """
    ...


def simulate_exit(plan: TradePlan, session_candles: list[Candle], cfg: StrategyConfig) -> Exit | None:
    """How the trade would have ended, using the rest of that day's candles."""
    ...


@dataclass
class BacktestTrade:
    day: date
    plan: TradePlan
    exit: Exit

    @property
    def r_multiple(self) -> float:
        ...


@dataclass
class BacktestResult:
    symbol: str
    sessions: int
    trades: list[BacktestTrade]

    def count(self, reason: str) -> int:
        ...

    @property
    def win_rate(self) -> float:
        ...

    @property
    def total_r(self) -> float:
        ...

    @property
    def avg_r(self) -> float:
        ...


def backtest(symbol: str, sessions: dict[date, list[Candle]], cfg: StrategyConfig) -> BacktestResult:
    """Run the rules on each finished past session (the reel's "last 59 sessions")."""
    ...
