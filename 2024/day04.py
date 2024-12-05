import re
from pathlib import Path

testinput = \
    """MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX""".split("\n")

prodinput = Path('day04.txt').read_text().strip().split("\n")

class TileMap(object):
    def __init__(self, tiles: list[str]):
        self._tiles = tiles

    def get(self, x: int, y: int) -> str:
        if x >= self.width() or y >= self.height() or x < 0 or y < 0:
            return None
        return self._tiles[y][x]

    def width(self) -> int:
        return len(self._tiles[0])

    def height(self) -> int:
        return len(self._tiles)

    def getLine(self,
                start: tuple[int, int],
                step: tuple[int, int]) -> str:
        cx = start[0]
        cy = start[1]
        tile = self.get(cx, cy)
        line = ""
        while tile is not None:
            cx += step[0]
            cy += step[1]
            if tile is not None:
                line += tile
            tile = self.get(cx, cy)
        return line


def getStrings(tm: TileMap):
    for row in range(tm.height()):
        # search from left column
        line = tm.getLine((0, row), (1, -1))
        yield line
        # yield line[::-1]
        line = tm.getLine((0, row), (1, 0))
        yield line
        # yield line[::-1]
        line = tm.getLine((0, row), (1, 1))
        yield line
        # yield line[::-1]

        # search from right column
        line = tm.getLine((tm.width()-1, row), (-1, -1))
        yield line
        # yield line[::-1]
        line = tm.getLine((tm.width()-1, row), (-1, 0))
        yield line
        # yield line[::-1]
        line = tm.getLine((tm.width()-1, row), (-1, 1))
        yield line
        # yield line[::-1]

    for col in range(tm.width()):
        # search from top row
        line = tm.getLine((col, tm.height()-1), (-1, 1))
        yield line
        # yield line[::-1]
        line = tm.getLine((col, tm.height()-1), (0, 1))
        yield line
        # yield line[::-1]
        line = tm.getLine((col, tm.height()-1), (1, 1))
        yield line
        # yield line[::-1]


tm = TileMap(testinput)

print(tm.width())
print(tm.height())

sum = 0
for line in getStrings(tm):
    sum += len(re.findall(r"XMAS", line))

print(sum)
