#!/usr/bin/env python3
import sys
from argparse import ArgumentParser
from pathlib import Path

import numpy as np
from PIL import Image


def img2bash(path: str | Path, width: int | None = None, height: int | None = None) -> None:
  "Convert an image at a path to bash. Prints bash source to stdout."
  with Image.open(path) as image:
    if (width != 0 or width is not None) or (height != 0 or height is not None):
      image = image.resize((width or image.width, height or image.height))

    print("# Generated with img2bash\n\n")

    for y in np.asarray(image):
      print(end="printf '")

      for i, x in enumerate(y):
        if i == 0:
          print(end=f"\\e[38;2;{x[0]};{x[1]};{x[2]}m")

        if x[3] == 0:
          print(end="  ")
          continue

        print(end="██")

      print("\\n'")

if __name__ == "__main__":
  parser = ArgumentParser("img2bash", usage="Generate a bash script from image")
  parser.add_argument("-i", "--input", help="file path", required=True)
  parser.add_argument("-w", "--width", help="width")
  parser.add_argument("-H", "--height", help="height")

  parsed = vars(parser.parse_args())

  img2bash(parsed.get("input", ""), int(parsed.get("width", 0)), int(parsed.get("height", 0)))
