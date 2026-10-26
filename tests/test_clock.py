# Source code is private. This file shows only its classes and function signatures.

import unittest
from datetime import date, time
from traday import clock


class CalendarTest(unittest.TestCase):

    def test_2026_holidays(self):
        ...

    def test_early_closes(self):
        ...

    def test_saturday_new_year_is_not_moved_to_friday(self):
        ...

    def test_status_and_next_session(self):
        ...

    def test_previous_sessions_skip_weekends(self):
        ...


if __name__ == '__main__':
    ...
