# Source code is private. This file shows only its classes and function signatures.

"""DEGIRO broker, through the community library `degiro-connector`.

DEGIRO has no official trading API. degiro-connector talks to the same private
web API that DEGIRO's own website uses: log in (with your 2FA code), look up a
product id, then "check" an order (DEGIRO prices it and returns a confirmation
id) and "confirm" it. It can break whenever DEGIRO changes their site, and you
are responsible for using it within your DEGIRO client agreement.

Install it with:  pip install -e ".[degiro]"
"""
from __future__ import annotations
import json
import logging
import os
import time
from pathlib import Path
from typing import Any
from ..config import DegiroConfig
from .base import OrderResult, Position
log = ...


class DegiroError(RuntimeError):
    ...


class _Problems(logging.Handler):
    """Keeps what degiro-connector logs when DEGIRO refuses a request (it returns None, not the reason)."""

    def __init__(self):
        ...

    def emit(self, record: logging.LogRecord) -> None:
        ...


def credentials_from_env():
    ...


def rows(section: Any) -> list[dict]:
    """DEGIRO's update payload nests {name, value} pairs; flatten each row to a dict."""
    ...


def pick_product(symbol: str, products: list[dict], preferred_exchange_ids: list[str]) -> dict | None:
    """The tradable USD stock whose ticker is exactly `symbol`, preferred exchanges first."""
    ...


class DegiroBroker:
    name = ...

    def __init__(self, cfg: DegiroConfig, state_dir: Path, live: bool, api: Any=None, sleep=time.sleep, monotonic=time.monotonic, poll_seconds: float=3.0):
        ...

    @property
    def api(self):
        ...

    def _connect(self):
        ...

    @staticmethod
    def _ensure_int_account(api) -> None:
        ...

    def _reconnect(self) -> None:
        ...

    def _call(self, action: str, retry: bool=True, **kwargs):
        """Call a degiro-connector action. Sessions expire, so reads log in again once.

        When DEGIRO refuses, `self.problem` says why (the library only logs it).
        """
        ...

    def search(self, text: str, limit: int=10) -> list[dict]:
        ...

    def product_id(self, symbol: str) -> int:
        ...

    def _symbol_for(self, product_id: Any) -> str:
        ...

    def update(self) -> dict:
        ...

    def snapshot(self) -> dict:
        """Cash, positions and open orders from one request (for the dashboard)."""
        ...

    def positions(self, data: dict | None=None) -> dict[str, Position]:
        ...

    def cash(self, data: dict | None=None) -> float:
        """Free trading space as DEGIRO reports it (in your account currency)."""
        ...

    def open_orders(self, data: dict | None=None) -> list[dict]:
        ...

    def _place(self, **fields) -> tuple[str, float]:
        ...

    def _held(self, symbol: str) -> float:
        ...

    def _wait_for(self, symbol: str, target_qty: float, increasing: bool) -> float:
        ...

    def buy(self, symbol: str, qty: int, limit_price: float, ref_price: float) -> OrderResult:
        ...

    def sell(self, symbol: str, qty: float, ref_price: float, limit_price: float | None=None) -> OrderResult:
        ...

    def place_stop(self, symbol: str, qty: float, stop_price: float) -> OrderResult:
        ...

    def cancel(self, order_id: str) -> bool:
        ...
