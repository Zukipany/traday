# Source code is private. This file shows only its classes and function signatures.

"""Phone access: pairing codes, what a paired phone may do, and turning `tailscale serve` on and off."""
import json
import os
import stat
import tempfile
import threading
import unittest
import urllib.error
import urllib.request
from http.server import ThreadingHTTPServer
from pathlib import Path
from helpers import FixedData
from traday import clock
from traday.config import Config
from traday.dashboard import App, make_handler
from traday.remote import TOKEN_KEY, Tailscale
PHONE = ...


class FakeTailscale:
    """Answers like the `tailscale` command line; `serve` can be told to ask for HTTPS first."""

    def __init__(self):
        ...

    def __call__(self, args, timeout):
        ...


class RemoteTest(unittest.TestCase):

    def setUp(self):
        ...

    def stop(self):
        ...

    def restore(self):
        ...

    def call(self, path, post=False, host=None, headers=None, body=None):
        ...

    def turn_on(self):
        ...

    def test_turning_on_makes_a_private_code_and_a_pairing_link(self):
        ...

    def test_tailscale_asking_to_allow_https_is_explained(self):
        ...

    def test_a_phone_needs_the_pairing_code(self):
        ...

    def test_proxied_requests_are_never_local_and_strangers_are_blocked(self):
        ...

    def test_without_tailscale_it_says_how_to_get_it(self):
        ...


if __name__ == '__main__':
    ...
