# Source code is private. This file shows only its classes and function signatures.

"""What the engine needs from a broker. Paper and DEGIRO both provide it."""
from __future__ import annotations
from dataclasses import dataclass
from typing import Protocol


@dataclass
class Position:
    symbol: str
    qty: float
    avg_price: float


@dataclass
class OrderResult:
    ok: bool
    order_id: str | None
    filled_qty: float
    avg_price: float | None
    fees: float
    message: str


class Broker(Protocol):
    name: str
    live: bool

    def cash(self) -> float:
        ...

    def positions(self) -> dict[str, Position]:
        ...

    def buy(self, symbol: str, qty: int, limit_price: float, ref_price: float) -> OrderResult:
        """Buy up to `limit_price`; returns once filled, or cancels after a timeout."""
        ...

    def sell(self, symbol: str, qty: float, ref_price: float, limit_price: float | None=None) -> OrderResult:
        """Sell at market (or at `limit_price`); returns once filled."""
        ...

    def place_stop(self, symbol: str, qty: float, stop_price: float) -> OrderResult:
        """Rest a protective stop-loss order. Returns at once with its order id."""
        ...

    def cancel(self, order_id: str) -> bool:
        ...
