import re
from pathlib import Path

testinput =\
    "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

# input = testinput
prodinput = Path('day03.txt').read_text()


def sumline(line):
    result = 0
    for found in re.findall(r"mul\(\d+,\d+\)", line):
        nums = found.strip("mul()").split(",")
        if len(nums) == 2:
            result += (int(nums[0]) * int(nums[1]))
    return result


# Part 1
print("Part 1: {}".format(sumline(prodinput)))


def sumline2(line):
    result = 0
    enabled = True
    for found in re.findall(r"mul\(\d+,\d+\)|do\(\)|don't\(\)", line):
        # print(found)
        if found == "do()":
            # print('enabling')
            enabled = True
        elif found == "don't()":
            # print('disabling')
            enabled = False
        else:
            nums = found.strip("mul()").split(",")
            if enabled and len(nums) == 2:
                result += (int(nums[0]) * int(nums[1]))
    return result


print("Part 2: {}".format(sumline2(prodinput)))
