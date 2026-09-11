"""Small helpers for the sample app."""

from datetime import datetime


def now_iso():
    # TODO: make the timezone configurable instead of always using local time
    return datetime.now().isoformat(timespec="seconds")
