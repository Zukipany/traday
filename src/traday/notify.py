# Source code is private. This file shows only its classes and function signatures.

"""Alerts: always to the console/log, optionally to your phone (ntfy or Telegram)."""
from __future__ import annotations
import json
import logging
import os
import urllib.error
import urllib.parse
import urllib.request
from .config import NotifyConfig
log = ...


class Notifier:

    def __init__(self, cfg: NotifyConfig | None=None):
        ...

    def send(self, title: str, message: str, urgent: bool=False) -> None:
        """Never raises: a failed alert must not stop the bot."""
        ...

    @staticmethod
    def _post(url: str, body: bytes, headers: dict) -> None:
        ...
