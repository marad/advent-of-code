from pathlib import Path
from functools import cmp_to_key

testinput = """47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
""".strip().splitlines()

prodinput = Path('day05.txt').read_text().strip().split("\n")


def get_rules(lines: list[str]) -> list[tuple[int, int]]:
    result = []
    for line in lines:
        if line.strip() == "":
            return result
        else:
            tmp = line.strip().split("|")
            result.append((int(tmp[0]), int(tmp[1])))
    return result


def get_pages(lines: list[str]) -> list[list[int]]:
    result = []
    for line in lines:
        if "," in line:
            tmp = line.split(",")
            result.append(list(map(lambda x: int(x), tmp)))
    return result


data = prodinput
rules = get_rules(data)
pages = get_pages(data)


def is_correct_order(page: list[int]) -> bool:
    for rule in rules:
        (a, b) = rule
        if a not in page or b not in page:
            continue
        idx1 = page.index(a)
        idx2 = page.index(b)
        if idx1 > idx2:
            return False
    return True


incorrect_pages = []
sum = 0
for page in pages:
    if is_correct_order(page):
        middle = page[int(len(page)/2)]
        sum += middle
    else:
        incorrect_pages.append(page)


def compare(a: int, b: int) -> int:
    if a == b:
        return 0

    for rule in rules:
        if a in rule and b in rule:
            if a == rule[0]:
                return -1
            else:
                return 1

    return 0


sum2 = 0
for page in incorrect_pages:
    s = sorted(page, key=cmp_to_key(compare))
    middle = s[int(len(s)/2)]
    sum2 += middle

print(sum2)
