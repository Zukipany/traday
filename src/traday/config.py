# Source code is private. This file shows only its classes and function signatures.

"""Settings from traday.toml, secrets from the environment (or a local .env)."""
from __future__ import annotations
import json
import os
import re
import tomllib
from dataclasses import MISSING, asdict, dataclass, field, fields
from pathlib import Path


class ConfigError(ValueError):
    ...


@dataclass
class GeneralConfig:
    mode: str
    state_dir: str
    poll_seconds: int


@dataclass
class StrategyConfig:
    range_minutes: int
    interval_minutes: int
    entry_cutoff: str
    flatten_at: str
    stop: str
    target_r: float
    min_range_pct: float
    max_range_pct: float
    max_signal_age_minutes: int


@dataclass
class RiskConfig:
    max_risk_per_trade: float
    max_position_value: float
    cash_buffer_pct: float
    max_open_positions: int
    max_trades_per_day: int
    max_daily_loss: float
    fee_per_order: float
    fx_fee_pct: float
    min_reward_to_cost: float
    blocked_symbols: list[str]


@dataclass
class PaperConfig:
    starting_cash: float
    slippage_pct: float


@dataclass
class DegiroConfig:
    entry_slippage_pct: float
    place_stop_loss: bool
    fill_timeout_seconds: int
    preferred_exchange_ids: list[str]
    product_ids: dict[str, int]


@dataclass
class NotifyConfig:
    ntfy_topic: str
    ntfy_server: str
DEFAULT_WATCHLIST = ...
TICKER = ...
SECTIONS = ...


@dataclass
class Config:
    general: GeneralConfig
    watchlist: list[str]
    strategy: StrategyConfig
    risk: RiskConfig
    paper: PaperConfig
    degiro: DegiroConfig
    notify: NotifyConfig
    path: Path | None

    @property
    def state_dir(self) -> Path:
        ...


def _coerce(name: str, f, value):
    """Check a value against the field's default type (numbers from a web form arrive as JSON)."""
    ...


def _section(cls, data: dict, name: str):
    ...


def _validate(cfg: Config) -> None:
    ...


def config_path(path: str | Path | None=None) -> Path:
    ...


def config_from_dict(raw: dict, path: Path | None=None) -> Config:
    """Build and check a Config from the same shape as traday.toml (also used by the dashboard)."""
    ...


def config_to_dict(cfg: Config) -> dict:
    ...


def load_config(path: str | Path | None=None) -> Config:
    """Read traday.toml. With no file at all, the defaults are used (paper mode)."""
    ...


def _toml(value) -> str:
    ...


def dump_config(cfg: Config) -> str:
    ...


def save_config(cfg: Config, path: str | Path) -> None:
    """Write traday.toml atomically, after checking that it reads back to the same settings."""
    ...


def load_dotenv(path: str | Path='.env') -> None:
    """Minimal .env reader: KEY=VALUE lines. Real environment variables win."""
    ...


def env_path(cfg: Config | None=None) -> Path:
    """The .env next to traday.toml (or in the current folder)."""
    ...


def save_env(path: str | Path, updates: dict[str, str | None]) -> None:
    """Set (or with None, remove) KEY=VALUE lines in a .env file readable only by you."""
    ...
