package main

import (
	"aoc2024/lib"
	"fmt"
	"strconv"

	g "github.com/oleiade/gomme"
)

const test = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

type Mul struct {
	a int
	b int
}

func (m Mul) valid() bool {
	return m.a >= 1 && m.a <= 999 && m.b >= 1 && m.b <= 999
}

func (m Mul) calc() int64 {
	return int64(m.a * m.b)
}

func main() {
	mul :=
		g.Map(
			g.Sequence(
				g.Token[string]("mul("),
				g.Digit1[string](),
				g.Token[string](","),
				g.Digit1[string](),
				g.Token[string](")"),
			),
			func(input []string) (Mul, error) {
				left, err := strconv.Atoi(input[1])
				if err != nil {
					return Mul{}, err
				}
				right, err := strconv.Atoi(input[3])
				if err != nil {
					return Mul{}, err
				}

				return Mul{a: left, b: right}, nil
			},
		)

	input, _ := lib.ReadDataFile("day03.txt")

	pos := 0
	var sum int64 = 0
	for pos < len(input) {
		res := mul(input[pos:])
		if res.Err != nil {
			pos++
			continue
		}

		mul := res.Output

		if mul.valid() {
			sum += mul.calc()
		}

		pos++
	}

	fmt.Println("Part 1: ", sum)

	// Part 2
	doToken := g.Token[string]("do()")
	dontToken := g.Token[string]("don't()")

	pos = 0
	sum = 0
	doing := true
	for pos < len(input) {
		slice := input[pos:]
		mulRes := mul(slice)
		doRes := doToken(slice)
		dontRes := dontToken(slice)

		// If parsed mul() then calculate
		if mulRes.Err == nil && doing && mulRes.Output.valid() {
			sum += mulRes.Output.calc()
		}

		if doRes.Err == nil {
			doing = true
		}

		if dontRes.Err == nil {
			doing = false
		}

		pos++
	}

	fmt.Println("Part 2: ", sum)
}
