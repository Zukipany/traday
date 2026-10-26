# Source code is private. This file shows only its classes and function signatures.

"""Trade history: every buy and sell in the journal, paired into trades, with the profit per trade,
per day and in total.

The journal writes an "entry" row when the bot buys and an "exit" row when it sells (the exit row
carries the fees of both orders and the P&L). A sell is paired with the oldest unsold buy of the same
stock. A trade's P&L counts on the day it was sold; trades still open have none yet.
"""
from __future__ import annotations
from datetime import datetime


def _day(ts: str) -> str:
    ...


def trades(rows: list[dict]) -> list[dict]:
    """Closed and open trades, oldest first, from journal rows (oldest first)."""
    ...


def summary(rows: list[dict], now: datetime | None=None) -> dict:
    """The history page: trades (newest first), one line per day, and the totals."""
    ...
