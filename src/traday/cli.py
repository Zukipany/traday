# Source code is private. This file shows only its classes and function signatures.

"""traday command line. Run `traday --help` (or `python -m traday --help`)."""
from __future__ import annotations
import argparse
import logging
import os
import shutil
import sys
from datetime import datetime, timedelta
from pathlib import Path
from . import clock, news, risk, strategy, timemachine
from .config import Config, ConfigError, load_config, load_dotenv
from .data import DataError, SyntheticData, YahooData, by_session, completed
from .journal import Journal
ROOT = ...


def demo_now() -> datetime:
    """10:30 ET on the most recent fully finished trading day (for --demo)."""
    ...


def make_data(args, now_fn=None):
    ...


def today_candles(data, symbol: str, cfg: Config, now: datetime):
    ...


def history(data, symbol: str, cfg: Config, now: datetime, days: int):
    ...


def bar(frac: float, width: int=30) -> str:
    ...


def money(x: float) -> str:
    ...


def cmd_init(args, cfg):
    ...


def cmd_clock(args, cfg):
    ...


def cmd_scan(args, cfg):
    ...


def cmd_plan(args, cfg):
    ...


def cmd_backtest(args, cfg):
    ...


def cmd_replay(args, cfg):
    ...


def cmd_news(args, cfg):
    ...


def make_broker(cfg: Config, live_flag: bool, state_dir: Path | None=None):
    ...


def confirm_live() -> None:
    ...


def cmd_run(args, cfg):
    ...


def run_demo(args, cfg):
    """A whole simulated trading day in a few seconds: fake prices, paper broker, fake clock."""
    ...


def cmd_dashboard(args, cfg):
    ...


def cmd_status(args, cfg):
    ...


def cmd_journal(args, cfg):
    ...


def cmd_kill(args, cfg):
    ...


def cmd_resume(args, cfg):
    ...


def cmd_paper_reset(args, cfg):
    ...


def cmd_degiro(args, cfg):
    ...


def cmd_trades(args, cfg):
    ...


def cmd_agents(args, cfg):
    ...


def build_parser() -> argparse.ArgumentParser:
    ...


def main(argv: list[str] | None=None) -> None:
    ...


if __name__ == '__main__':
    ...
