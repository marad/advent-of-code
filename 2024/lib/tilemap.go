package lib

import (
	"fmt"
	"iter"
)

type TileMap struct {
	Lines [][]byte
}

type Tile struct {
	XY
	Value byte
}

func NewTilemap(fname string) (TileMap, error) {
	lines, err := ReadLines(fname)
	if err != nil {
		return TileMap{}, err
	}
	bytemap := [][]byte{}
	for _, line := range lines {
		bytemap = append(bytemap, []byte(line))
	}

	return TileMap{Lines: bytemap}, nil
}

func (m TileMap) Width() int {
	return len(m.Lines[0])
}

func (m TileMap) Height() int {
	return len(m.Lines)
}

func (m TileMap) InMap(xy XY) bool {
	return (xy.X >= 0 && xy.X < m.Width()) && (xy.Y >= 0 && xy.Y < m.Height())
}

func (m TileMap) At(xy XY) (byte, error) {
	if !m.InMap(xy) {
		return 0, fmt.Errorf("Point (%d, %d) is outside of the tilemap", xy.X, xy.Y)
	}
	return m.Lines[xy.Y][xy.X], nil
}

func (m TileMap) Set(xy XY, value byte) {
	m.Lines[xy.Y][xy.X] = value
}

// Iterates over all tiles that match the predicate
func (m TileMap) FindAll(predicate func(Tile) bool) iter.Seq[Tile] {
	return func(yield func(Tile) bool) {
		for y := range m.Height() {
			for x := range m.Width() {
				value := m.Lines[y][x]
				tile := Tile{XY{x, y}, value}
				if predicate(tile) {
					if !yield(tile) {
						return
					}
				}
			}
		}
	}
}

func (m TileMap) FindAllTiles(name byte) iter.Seq[Tile] {
	return m.FindAll(func(t Tile) bool { return t.Value == name })
}

func (m TileMap) FindTile(name byte) (Tile, error) {
	for y := range m.Height() {
		for x := range m.Width() {
			value := m.Lines[y][x]
			if value == name {
				return Tile{XY{x, y}, value}, nil
			}
		}
	}
	return Tile{}, fmt.Errorf("Tile %s not found!", string(name))
}

func (m TileMap) Print() {
	for _, line := range m.Lines {
		fmt.Println(line)
	}
}
