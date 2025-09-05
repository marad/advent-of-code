Red [Title: "Advent Of Code 2016 - Day 01"]

data: trim/all read %01.txt
;data: trim/all "R8, R4, R4, R8" ; test data

do %../vec.red
do %../grammar.red

; Part 1 vars
pos: [0 0]
dir: [0 1]

; Part 2 vars
visited: [0 0]
hqpos: none


integer: grammar/integer
rules: [
  any[
    copy D ["L" | "R"]
    copy num integer
    (
      num: to-integer num
      switch D [
        "L" [dir: vec/rotate-90-left dir]
        "R" [dir: vec/rotate-90-right dir]
      ]

      repeat i num [
        pos: vec/add pos dir

        if find/skip visited pos 2 [
          if hqpos = none [
            hqpos: copy pos
          ]
        ]

        append visited pos
      ]
    )
    any[","]
  ] 
]


parse data rules

print ["Part 1:" vec/manhattan-length pos]
print ["Part 2:" vec/manhattan-length hqpos]

