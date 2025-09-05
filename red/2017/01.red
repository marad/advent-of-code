Red [Title: "Advent Of Code 2017 - Day 01"]


data: trim/all read %01.txt
;data: "12131415"

len: length? data
half: len / 2

sum: 0
sum2: 0

repeat index len [
  next-index: max 1 (mod (index + 1) (len + 1))
  next-index2: 1 + mod (index - 1 + half) len
  c: pick data index
  nc: pick data next-index
  nc2: pick data next-index2

  ;print ["Current index" index "char:" c]
  ;print ["Next index" next-index "char:" nc]
  ;print ["Next index" next-index2 "char:" nc2]
  
  if c = nc [
    sum: sum + (to-integer to-string c)
  ] 

  if c = nc2 [
    sum2: sum2 + (to-integer to-string c)
  ]
]

print ["Part 1:" sum]
print ["Part 2:" sum2]

