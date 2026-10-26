# Source code is private. This file shows only its classes and function signatures.

"""The 11 agents: who does what inside traday, drawn as the reel's pixel critters.

Every agent is a part of the real code (named in `code`):

  Chart Scanner    the opening range of every watchlist stock      strategy.opening_range/evaluate
  News Monitor     headlines, the ones that move a stock marked !  news.py
  Entry Timer      the 5-minute close above the range: buy now     strategy.evaluate, engine._scan
  Exit Planner     stop, target, and the sell-by time              strategy.plan_for/first_touch
  Time Machine     the rest of today replayed 10,000 times         timemachine.py
  Risk Manager     yes or no against your limits                   risk.check
  Accountant       how many shares, fees and FX, cash and P&L      risk.check sizing, journal.py
  Order Executor   the orders, on paper or at DEGIRO               brokers/
  Alerts           your phone: ntfy or Telegram                    notify.py
  Backtester       the same rules on the last 59 sessions          strategy.backtest
  Position Watcher open trades, the kill switch, DEGIRO's view     engine._manage_open/_reconcile

The Autopilot (engine.py) is the loop that wakes them in turn. `cast()` describes them with your
own settings, `live()` says what each is doing right now, and `story()` runs the real engine on the
reel's TSLA day and tells that trade as a hand-off from one agent to the next.
"""
from __future__ import annotations
import copy
import json
import tempfile
from dataclasses import dataclass
from datetime import date, datetime, timedelta
from pathlib import Path
from . import clock, risk, strategy, timemachine
from .brokers.paper import PaperBroker
from .config import Config
from .data import Candle, SyntheticData
from .engine import Engine
from .journal import Journal
from .notify import Notifier
PALETTE = ...
_BLOCKS = ...
BLOCK = ...


def _critter(blink: bool=False, step: bool=False) -> list[str]:
    ...
CRITTER = ...
_FONT = ...


def _exit_sign() -> list[str]:
    ...
PROPS = ...
BODY_AT = ...
HAND_R = ...
HEAD_AT = ...


@dataclass(frozen=True)
class Agent:
    id: str
    name: str
    props: tuple[tuple[str, int, int], ...]
    tagline: str
    job: str
    when: str
    code: str
    skill: str
    ask: str


def _hand(prop: str, dx: int=0) -> tuple[str, int, int]:
    ...
AGENTS: tuple[Agent, ...]
BY_ID = ...


def _usd(x: float, sign: bool=False) -> str:
    ...


def _hhmm(text: str) -> str:
    ...


def _range_end(cfg: Config) -> str:
    ...


def rules(agent_id: str, cfg: Config, alerts: dict | None=None) -> list[str]:
    """The agent's job in numbers: your own settings."""
    ...


def alerts_on(cfg: Config) -> dict:
    """Which phone channels are set up (never the topic or the token themselves)."""
    ...


def sprite(agent: Agent) -> dict:
    ...


def cast(cfg: Config, alerts: dict | None=None) -> list[dict]:
    ...


def schedule(cfg: Config) -> dict:
    """The day's clock (New York) the agents work to, for the timeline."""
    ...


def _say(state: str, says: str) -> dict:
    ...


def live(status: dict, scan: dict | None, journal_rows: list[dict], cfg: Config, alerts: dict) -> dict:
    """One line per agent from the dashboard's own status, scan and today's journal (oldest first).

    States: idle (ready), working, done, alert (needs you), off.
    """
    ...


def autopilot(status: dict) -> dict:
    ...
REEL_DAY = ...


def _bar(day: date, hhmm: str, o: float, h: float, lo: float, c: float, v: float=1000000.0) -> Candle:
    ...


def reel_candles(day: date=REEL_DAY) -> list[Candle]:
    """The reel's TSLA morning (range 354.47-362.18, the 10:10 candle closes at 364.18), then the target."""
    ...


class _Quiet(Notifier):
    """Keeps the story's alerts to itself: nothing reaches your phone or the log."""

    def send(self, title: str, message: str, urgent: bool=False) -> None:
        ...


class _Clock:

    def __init__(self, start: datetime):
        ...

    def __call__(self) -> datetime:
        ...

    def sleep(self, seconds: float) -> None:
        ...


class _Finished:
    """Candles as the bot would see them: only those finished by the clock's time."""

    def __init__(self, candles: list[Candle], now_fn):
        ...

    def intraday(self, symbol, days=1, interval_minutes=5):
        ...


def story(cfg: Config, sims: int=10000) -> dict:
    """Run the real engine on the reel's TSLA day (paper, in a scratch folder) and tell it step by step."""
    ...
PAGE = ...
EMBED = ...


def export_html(cfg: Config) -> str:
    """The agents page as one file that works without traday running (the story and the cast built in)."""
    ...
