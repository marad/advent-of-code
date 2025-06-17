package main

import (
	"aoc2024/lib"
	"fmt"

	"github.com/eliben/gogl/hashset"
)

func main() {
	tm, _ := lib.NewTilemap("day06.txt")
	start, _ := tm.FindTile('^')

	result, _ := Simulate(tm, start.XY)
	fmt.Println("Part 1: ", result)

	// Brute force part 2 like there was no tomorrow!
	count := 0
	for tile := range tm.FindAllTiles('.') {
		tm.Set(tile.XY, '#')
		_, err := Simulate(tm, start.XY)
		if err != nil {
			count++
		}
		tm.Set(tile.XY, '.')
	}
	fmt.Println("Part 2: ", count)
}

var loopError = fmt.Errorf("Guard has a loop")

type PosDir struct {
	pos lib.XY
	dir lib.Dir
}

func Simulate(tm lib.TileMap, start lib.XY) (int, error) {

	dir := lib.Up
	positions := hashset.New[lib.XY]()
	posWithDir := hashset.New[PosDir]()
	current := start
	positions.Add(current)
	posWithDir.Add(PosDir{current, dir})

	for true {
		next := current.ApplyDir(dir)
		nextTile, err := tm.At(next)

		if err != nil {
			// Outside the map
			break
		}

		if nextTile == '#' {
			dir = lib.RotateRight90(dir)
			continue
		}

		current = next
		positions.Add(current)
		posDir := PosDir{current, dir}

		if posWithDir.Contains(posDir) {
			return 0, loopError
		}

		posWithDir.Add(posDir)
	}

	return positions.Len(), nil
}
