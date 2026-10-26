# Source code is private. This file shows only its classes and function signatures.

"""Paper broker: a local account file with simulated fills and DEGIRO-like fees.

DEGIRO has no paper/demo account, so this is where every strategy change gets
tested first. Fills happen at the price the engine passes in, made slightly worse
by `slippage_pct`. Stops are tracked by the engine, not here.
"""
from __future__ import annotations
import itertools
import json
from datetime import datetime
from pathlib import Path
from .. import clock
from ..config import PaperConfig, RiskConfig
from .base import OrderResult, Position


class PaperBroker:
    name = ...
    live = ...

    def __init__(self, state_dir: Path, paper: PaperConfig, risk: RiskConfig, now_fn=clock.now_et):
        ...

    def _load(self) -> dict:
        ...

    def _save(self) -> None:
        ...

    def reset(self) -> None:
        ...

    def _fees(self, value: float) -> float:
        ...

    def _fill(self, side: str, symbol: str, qty: float, price: float) -> OrderResult:
        ...

    def cash(self) -> float:
        ...

    def positions(self) -> dict[str, Position]:
        ...

    def buy(self, symbol: str, qty: int, limit_price: float, ref_price: float) -> OrderResult:
        ...

    def sell(self, symbol: str, qty: float, ref_price: float, limit_price: float | None=None) -> OrderResult:
        ...

    def place_stop(self, symbol: str, qty: float, stop_price: float) -> OrderResult:
        ...

    def cancel(self, order_id: str) -> bool:
        ...
