# Source code is private. This file shows only its classes and function signatures.

"""Downloads the official Swift toolchain for Linux (the `swift` Docker image) without Docker.

    python3 tools/swiftcheck/get_swift.py            # -> tools/swiftcheck/.toolchain/usr/bin/swift

It reads the image from Google's Docker Hub mirror (mirror.gcr.io), which needs no login and has no
pull limit, and unpacks its layers into a folder. About 1.1 GB to download, 3.6 GB on disk. The
binaries run directly on Ubuntu 24.04 (the image's own system); nothing is installed system-wide.
"""
import json
import os
import subprocess
import sys
import urllib.request
from pathlib import Path
REGISTRY = ...
IMAGE = ...
TAG = ...
OUT = ...
ACCEPT = ...


def get(path: str, accept: str | None=None):
    ...


def main() -> None:
    ...


if __name__ == '__main__':
    ...
