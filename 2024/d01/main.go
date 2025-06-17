package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"slices"
	"strconv"
	"strings"

	"github.com/samber/lo"
)

func main() {
	file, _ := os.Open("day01.txt")
	defer file.Close()

	left := []int{}
	right := []int{}
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		tmp := strings.Split(scanner.Text(), "   ")

		li, _ := strconv.Atoi(tmp[0])
		left = append(left, li)

		ri, _ := strconv.Atoi(tmp[1])
		right = append(right, ri)
	}

	slices.Sort(left)
	slices.Sort(right)

	sum := lo.Sum(
		lo.Map(
			lo.Zip2(left, right),
			func(t lo.Tuple2[int, int], _ int) int {
				return int(math.Abs(float64(t.A) - float64(t.B)))
			}))

	fmt.Println("Part 1 ", sum)

	// Part 2
	counts := make(map[int]int)
	for _, num := range right {
		counts[num] += 1
	}

	sum2 := lo.Sum(
		lo.Map(
			left,
			func(n int, _ int) int {
				return n * counts[n]
			}),
	)

	fmt.Println("Part 2 ", sum2)

}
