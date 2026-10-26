# Source code is private. This file shows only its classes and function signatures.

"""Phone access: control the dashboard from your phone, privately, through Tailscale.

The dashboard keeps listening on 127.0.0.1 only. `tailscale serve` (part of the free Tailscale
app) forwards https://<this-computer>.<your-tailnet>.ts.net to it. That address only works on
devices signed in to your own Tailscale account: the traffic is encrypted, has a real HTTPS
certificate and is invisible to the rest of the internet.

On top of that, every request from a phone has to carry the pairing code: a long random secret
(192 bits, so guessing is hopeless) kept in .env as TRADAY_REMOTE_TOKEN. A phone gets it once, by
opening the pairing link or scanning its QR code. A new code unpairs every phone at once.
"""
from __future__ import annotations
import hmac
import json
import os
import re
import secrets
import shutil
import subprocess
import threading
import time
from pathlib import Path
from .config import save_env
TOKEN_KEY = ...
COOKIE = ...
CANDIDATES = ...


def _run(args: list[str], timeout: float) -> tuple[int, str]:
    ...


class Tailscale:
    """The few `tailscale` commands traday needs. `run` is replaced in tests."""

    def __init__(self, run=_run, candidates=CANDIDATES):
        ...

    def binary(self) -> str | None:
        ...

    def _call(self, *args: str, timeout: float=15.0) -> tuple[int, str]:
        ...

    def status(self) -> dict:
        ...

    def serving(self, port: int) -> bool:
        ...

    def enable(self, port: int) -> tuple[bool, str]:
        ...

    def disable(self) -> tuple[bool, str]:
        ...


class RemoteAccess:
    """The pairing code, and turning `tailscale serve` on and off."""

    def __init__(self, env_file: Path, tailscale: Tailscale | None=None):
        ...

    @staticmethod
    def token() -> str:
        ...

    def new_token(self) -> str:
        ...

    def ensure_token(self) -> str:
        ...

    def check(self, presented: str | None) -> bool:
        """Is this the current pairing code? (Compared in constant time.)"""
        ...

    def status(self, port: int, force: bool=False) -> dict:
        ...

    def enable(self, port: int) -> dict:
        ...

    def disable(self, port: int) -> dict:
        ...
