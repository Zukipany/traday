# Source code is private. This file shows only its classes and function signatures.

"""Turns the frames shoot.mjs saved (GIF_FRAMES) into docs/img/agents.gif and docs/img/story.gif.

    python3 tools/screenshots/gif.py FRAMES_DIR docs/img      # needs Pillow (pip install pillow)
"""
import sys
from pathlib import Path
from PIL import Image


def gif(frames: list[Path], out: Path, ms: list[int] | int, width: int) -> None:
    ...


def main() -> None:
    ...


if __name__ == '__main__':
    ...
