Red [Title: "Advent Of Code 2015 - Day 01"]

content: to-string read %01.txt
floor: 0
pos: 1
basement: 0

foreach c content [
  if c = #"(" [ floor: floor + 1 ]
  if c = #")" [ floor: floor - 1 ]
  if (floor = -1) and (basement = 0) [ basement: pos ]
  pos: pos + 1
]

print [ "Part 1:" floor ]
print [ "Part 2:" basement ]


