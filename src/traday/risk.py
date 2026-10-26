# Source code is private. This file shows only its classes and function signatures.

"""Risk Manager: sizes each trade and blocks anything over your limits."""
from __future__ import annotations
import math
from dataclasses import dataclass, field
from .config import RiskConfig
from .strategy import TradePlan


@dataclass
class RiskDecision:
    approved: bool
    qty: int
    reasons: list[str]
    risk: float
    reward: float
    costs: float

    def summary(self) -> str:
        ...


def round_trip_costs(value: float, cfg: RiskConfig) -> float:
    ...


def check(plan: TradePlan, cfg: RiskConfig, *, cash: float, open_positions: int, holding: set[str], trades_today: int, realized_pnl_today: float, killed: bool=False) -> RiskDecision:
    ...


def net_result(plan: TradePlan, exit_price: float, cfg: RiskConfig, cash: float) -> tuple[int, float, float]:
    """(shares, gross P&L, costs) of one trade sized and checked like the bot does; 0 shares if it would skip it."""
    ...
