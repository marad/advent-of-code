package lib

type Edge struct {
	source, target int
}

type Graph struct {
	g map[int]int
}

func NewGraph(edges []Edge) Graph {
	m := make(map[int]int)
	for _, edge := range edges {
		m[edge.source] = edge.target
	}
	return Graph{m}
}
