package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"

	"github.com/samber/lo"
)

func main() {
	file, _ := os.Open("day02.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)

	count := 0
	count2 := 0
	for scanner.Scan() {
		digits := lo.Map(
			strings.Split(scanner.Text(), " "),
			func(s string, _ int) int {
				value, _ := strconv.Atoi(s)
				return value
			},
		)

		if isSafe(digits) {
			count++
		}
		if isSafeWithDamping(digits) {
			count2++
		}
	}

	fmt.Println("Part 1:", count)
	fmt.Println("Part 2:", count2)
}

func isSafe(digits []int) bool {
	diffs := []int{}
	increasing := true
	decreasing := true
	diffOk := true
	for idx, d := range digits {
		if idx > 0 {
			diff := digits[idx-1] - d
			diffs = append(diffs, diff)
			if diff < 0 {
				increasing = false
			}
			if diff > 0 {
				decreasing = false
			}
			if abs(diff) < 1 || abs(diff) > 3 {
				diffOk = false
			}
		}
	}
	return (increasing || decreasing) && diffOk
}

func isSafeWithDamping(digits []int) bool {
	for i := range digits {
		if isSafe(removeAtIndex(digits, i)) {
			return true
		}
	}
	return false
}

func removeAtIndex(original []int, index int) []int {
	if index < 0 || index >= len(original) {
		return original // index out of range; return unchanged copy
	}

	// Make a copy without the element at the given index
	newSlice := make([]int, 0, len(original)-1)
	newSlice = append(newSlice, original[:index]...)
	newSlice = append(newSlice, original[index+1:]...)
	return newSlice
}

func abs(i int) int {
	if i < 0 {
		return -i
	}
	return i
}
