Red [Title: "Advent Of Code 2015 - Day 04"]

pass: "ckczppom"
;pass: "abcdef"

encode: function [num] [
  checksum append pass num 'md5
]

check: function [num] [
  hash: encode num
  ;print hash
  ;print hash/1
  ;print hash/2
  ;print hash/3 >> 4
  all [
    hash/1 = 0
    hash/2 = 0
    (hash/3 << 4) = 0
  ]
]

;print encode 609043
;print check 609043


num: 0
forever [
  if check num [
    break
  ]
  num: num + 1

  if (mod num 10000) = 0[
    print num
  ]
]

print ["Part 1" num]

