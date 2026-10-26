# Source code is private. This file shows only its classes and function signatures.

import tempfile
import unittest
from pathlib import Path
from traday.brokers.paper import PaperBroker
from traday.config import PaperConfig, RiskConfig


class PaperBrokerTest(unittest.TestCase):

    def setUp(self):
        ...

    def test_round_trip(self):
        ...

    def test_persists(self):
        ...

    def test_refuses_overspend_and_oversell(self):
        ...

    def test_limit_caps_the_fill(self):
        ...


if __name__ == '__main__':
    ...
