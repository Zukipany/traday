# Source code is private. This file shows only its classes and function signatures.

import importlib.util
import tempfile
import unittest
from pathlib import Path
from types import SimpleNamespace
from traday.brokers import degiro
from traday.config import DegiroConfig
HAVE_CONNECTOR = ...
PRODUCTS = ...


def update_payload(size: float) -> dict:
    ...


class FakeAPI:

    def __init__(self):
        ...

    def connect(self):
        ...

    def product_search(self, product_request):
        ...

    def get_update(self, request_list, raw=True):
        ...

    def check_order(self, order):
        ...

    def confirm_order(self, confirmation_id, order):
        ...

    def delete_order(self, order_id):
        ...


class ParsingTest(unittest.TestCase):

    def test_pick_product(self):
        ...

    def test_rows(self):
        ...


@unittest.skipUnless(HAVE_CONNECTOR, "pip install -e '.[degiro]' to run the DEGIRO tests")
class DegiroBrokerTest(unittest.TestCase):

    def make(self, live=True):
        ...

    def test_account(self):
        ...

    def test_a_refused_account_read_says_why(self):
        ...

    def test_buy_checks_then_confirms_a_limit_order(self):
        ...

    def test_stop_and_cancel(self):
        ...

    def test_sell_market(self):
        ...

    def test_unfilled_buy_is_cancelled(self):
        ...

    def test_read_only_refuses_orders(self):
        ...


if __name__ == '__main__':
    ...
