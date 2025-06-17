package main

import (
	"aoc2024/lib"
	"fmt"
)

func tiles(char byte) func(lib.Tile) bool {
	return func(tile lib.Tile) bool {
		return tile.Value == char
	}
}

func Check(tm lib.TileMap, start lib.XY, dir lib.Dir, word string) bool {
	current := start
	for _, expectedChar := range word {
		ch, err := tm.At(current)
		if err != nil || ch != byte(expectedChar) {
			return false
		}
		current.Move(dir)
	}
	return true
}

func CheckPt2(tm lib.TileMap, start lib.XY) bool {
	count := 0
	if Check(tm, start.ApplyDir(lib.UpLeft), lib.DownRight, "MAS") {
		count++
	}
	if Check(tm, start.ApplyDir(lib.DownLeft), lib.UpRight, "MAS") {
		count++
	}
	if Check(tm, start.ApplyDir(lib.UpRight), lib.DownLeft, "MAS") {
		count++
	}
	if Check(tm, start.ApplyDir(lib.DownRight), lib.UpLeft, "MAS") {
		count++
	}
	return count >= 2
}

func main() {
	tm, _ := lib.NewTilemap("day04.txt")
	count := 0
	for tile := range tm.FindAll(tiles('X')) {
		for dir := range lib.Dirs {
			if Check(tm, tile.XY, lib.Dir(dir), "XMAS") {
				count++
			}
		}
	}

	fmt.Println("Part 1: ", count)

	tm, _ = lib.NewTilemap("day04.txt")
	count = 0
	for tile := range tm.FindAll(tiles('A')) {
		if CheckPt2(tm, tile.XY) {
			count++
		}
	}

	fmt.Println("Part 2: ", count)
}
