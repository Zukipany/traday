# Source code is private. This file shows only its classes and function signatures.

import tempfile
import unittest
from datetime import datetime, timezone
from pathlib import Path
from traday import data, news
from traday.config import ConfigError, load_config
ROOT = ...
RSS = ...


class ConfigTest(unittest.TestCase):

    def test_example_config_loads(self):
        ...

    def test_typos_are_errors(self):
        ...

    def test_missing_file_means_defaults(self):
        ...


class NewsTest(unittest.TestCase):

    def test_parse_and_filter(self):
        ...


class YahooParseTest(unittest.TestCase):

    def test_parse_chart(self):
        ...

    def test_synthetic_is_deterministic_and_respects_now(self):
        ...


if __name__ == '__main__':
    ...
