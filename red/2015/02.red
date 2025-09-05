Red [Title: "Advent Of Code 2015 - Day 02"]

slack: function [b] [
  tmp: sort copy b
  tmp/1 * tmp/2
]

surface: function [b] [
  (2 * b/1 * b/2) + 
  (2 * b/2 * b/3) +
  (2 * b/3 * b/1) +
  (slack b)
]

ribbon: function [box] [
  b: sort copy box
  (b/1 + b/1 + b/2 + b/2) +
  (b/1 * b/2 * b/3)
]

total: 0
total2: 0

foreach line read/lines %02.txt [
  box: split line #"x"
  box: reduce [
    to-integer box/1
    to-integer box/2
    to-integer box/3
  ]
  total: total + surface box
  total2: total2 + ribbon box
]

print ["Part 1:" total]
print ["Part 2:" total2]

