package main

import (
	"aoc2024/lib"
	"fmt"
	"slices"
	"strconv"

	g "github.com/hmdsefi/gograph"
	p "github.com/oleiade/gomme"
)

type Rule struct {
	fst, snd int
}

var pageOrder = p.Map(
	p.Sequence(
		p.Digit1[string](),
		p.Token[string]("|"),
		p.Digit1[string](),
	),
	func(data []string) (Rule, error) {
		fst, _ := strconv.Atoi(data[0])
		snd, _ := strconv.Atoi(data[2])
		return Rule{fst, snd}, nil
	},
)
var ParseRuleSection = p.SeparatedList0(pageOrder, p.LF[string]())

var PageList = p.SeparatedList0(p.Map(p.Digit1[string](), func(in string) (int, error) {
	i, _ := strconv.Atoi(in)
	return i, nil
}),
	p.Token[string](","),
)

var ParsePageLists = p.SeparatedList0(PageList, p.LF[string]())

func makeMapping(list []int) map[int]int {
	m := make(map[int]int)
	for idx, page := range list {
		m[page] = idx
	}
	return m
}

func validateList(list []int, rules []Rule) bool {
	mapping := makeMapping(list)
	for _, rule := range rules {
		fi, fok := mapping[rule.fst]
		si, sok := mapping[rule.snd]
		if fok && sok && fi > si {
			return false
		}
	}
	return true
}

func main() {
	sections, _ := lib.ReadSections("day05.txt")

	rules := ParseRuleSection(sections[0]).Output
	lists := ParsePageLists(sections[1]).Output

	// Part 1
	sum := 0
	sum2 := 0
	for _, list := range lists {
		valid := validateList(list, rules)
		if valid {
			mid := list[len(list)/2]
			sum += mid
		} else {
			sorted := SortList(list, rules)
			mid := sorted[len(sorted)/2]
			sum2 += mid
		}
	}

	fmt.Println("Part 1: ", sum)
	fmt.Println("Part 2: ", sum2)

	// Part 2
}

func GetOrCreateVertex(graph g.Graph[int], id int) *g.Vertex[int] {
	v := graph.AddVertexByLabel(id)
	if v == nil {
		return graph.GetVertexByID(id)
	}
	return v
}

func SortList(list []int, rules []Rule) []int {
	result := []int{}
	graph := g.New[int](g.Directed())

	// construct a graph
	for _, rule := range rules {
		if !slices.Contains(list, rule.fst) || !slices.Contains(list, rule.snd) {
			continue
		}
		u := GetOrCreateVertex(graph, rule.fst)
		v := GetOrCreateVertex(graph, rule.snd)
		graph.AddEdge(u, v)
	}

	sorted, _ := g.TopologySort(graph)

	for _, v := range sorted {
		result = append(result, v.Label())
	}

	return result
}
