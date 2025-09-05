Red [Title: "Advent Of Code 2015 - Day 03"]

data: trim/head/tail read %03.txt
;data: "^^v^^v^^v^^v"
;data: "^^>v<"

do %../vec.red

get-dir: function [instr] [
  case [
    instr = #">" [return vec/right]
    instr = #"<" [return vec/left]
    instr = #"^^" [return vec/up]
    instr = #"v" [return vec/down]
  ]
]

ctx: context [

  instructions: ""
  visited: [[0 0]]
  pos: [0 0]

  simulate: does [
    foreach instr instructions [
      dir: get-dir instr
      pos: vec/add pos dir
      append/only visited pos
    ]
  ]

]


part1: make ctx [instructions: data]
part1/simulate

print ["Part 1:" length? unique part1/visited]


santa-instrs: ""
rsanta-instrs: ""

foreach [s r] data [
  append santa-instrs s
  append rsanta-instrs r
]

santa: make ctx [instructions: santa-instrs]
robo-santa: make ctx [instructions: rsanta-instrs]


santa/simulate
robo-santa/simulate

print [
  "Part 2:" 
  length? unique union santa/visited robo-santa/visited
]

