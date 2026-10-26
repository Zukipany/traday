# Source code is private. This file shows only its classes and function signatures.

"""NYSE trading calendar: sessions, holidays and early closes, in New York time."""
from __future__ import annotations
from datetime import date, datetime, time, timedelta
from zoneinfo import ZoneInfo
ET = ...
OPEN = ...
CLOSE = ...
EARLY_CLOSE = ...


def now_et() -> datetime:
    ...


def at(day: date, hhmm: str | time) -> datetime:
    """`day` at a wall-clock time in New York."""
    ...


def _easter(year: int) -> date:
    ...


def _nth_weekday(year: int, month: int, weekday: int, n: int) -> date:
    """n-th `weekday` (Mon=0) of the month; n=-1 for the last one."""
    ...


def _observed(d: date) -> date:
    ...


def holidays(year: int) -> dict[date, str]:
    ...


def early_closes(year: int) -> set[date]:
    ...


def holiday_name(day: date) -> str | None:
    ...


def session(day: date) -> tuple[datetime, datetime] | None:
    """(open, close) for a trading day, or None when the market is shut."""
    ...


def is_trading_day(day: date) -> bool:
    ...


def next_session(now: datetime) -> tuple[datetime, datetime]:
    """The session that is open now, or the next one to open."""
    ...


def previous_sessions(day: date, count: int) -> list[date]:
    """The `count` trading days before `day`, oldest first."""
    ...


def last_full_session(now: datetime) -> date:
    """The most recent trading day whose session has finished."""
    ...


def market_status(now: datetime) -> str:
    ...
