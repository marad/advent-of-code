Red [Title: "Advent Of Code 2015 - Day 03"]

data: trim/head/tail read %03.txt
;data: "^^v^^v^^v^^v"
;data: "^^>v<"

do %../vec.red

visited: [[0 0]]
pos: [0 0]

get-dir: function [instr] [
  case [
    instr = #">" [return vec/right]
    instr = #"<" [return vec/left]
    instr = #"^^" [return vec/up]
    instr = #"v" [return vec/down]
  ]
]


foreach instr data [
  dir: get-dir instr
  pos: vec/add pos dir
  append/only visited pos
]

print ["Part 1:" length? unique visited]


santa-pos: [0 0]
robo-santa-pos: [0 0]
houses: [[0 0]]

foreach [s r] data [
  sdir: get-dir s 
  santa-pos: vec/add santa-pos sdir
  append/only houses santa-pos

  rdir: get-dir r
  robo-santa-pos: vec/add robo-santa-pos rdir
  append/only houses robo-santa-pos
]

print ["Part 2:" length? unique houses]

