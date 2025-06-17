package main

import (
	"aoc2024/lib"
	"fmt"
	"strconv"
	"strings"
)

func main() {
	// lines, _ := lib.ReadLines("day07_test.txt")
	lines, _ := lib.ReadLines("day07.txt")
	var sum int64 = 0
	for _, line := range lines {
		tmp := strings.Split(line, ":")
		total, _ := strconv.ParseInt(tmp[0], 10, 64)
		numbers := []int64{}
		for num := range strings.SplitSeq(strings.Trim(tmp[1], " "), " ") {
			converted, _ := strconv.ParseInt(num, 10, 64)
			numbers = append(numbers, converted)
		}

		if calc(0, total, numbers) {
			sum += total
		}
	}

	fmt.Println("Part 1 ", sum)
}

func calc(sofar int64, expected int64, togo []int64) bool {
	if len(togo) == 0 {
		return sofar == expected
	}

	head := togo[0]
	tail := togo[1:]
	if calc(sofar+head, expected, tail) {
		return true
	}
	if sofar == 0 {
		sofar = 1 // multiplication has different neutral element
	}
	if calc(sofar*head, expected, tail) {
		return true
	}

	return false
}
