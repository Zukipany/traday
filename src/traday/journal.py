# Source code is private. This file shows only its classes and function signatures.

"""Journal: every signal, block, order, fill and exit, one JSON line each."""
from __future__ import annotations
import json
from datetime import date, datetime
from pathlib import Path
from . import clock


class Journal:

    def __init__(self, state_dir: Path):
        ...

    def log(self, event: str, now: datetime | None=None, **data) -> dict:
        ...

    def rows(self, since: date | None=None) -> list[dict]:
        ...
