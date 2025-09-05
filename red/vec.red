comment {
  Contains functions for working with vectors.
  Vector is represented as block with two numbers: [1 2]
}

Red [ Title: "Vectors" ]


vec: context [
  up: [0 1]
  down: [0 -1]
  right: [1 0]
  left: [-1 0]

  rotate-90-right: func [v] [
    reduce [ v/2 
             negate v/1 ]
  ]

  rotate-90-left: func [v] [
    reduce [ negate v/2 
             v/1 ]
  ]

  manhattan-length: function [v] [
    (absolute v/1) + (absolute v/2)
  ]

  add: func [v w /times num [integer!]] [
    if num = none [num: 1]
    reduce [ v/1 + (w/1 * num) 
             v/2 + (w/2 * num) ]
  ]

  subtract: func [v w /times num [integer!]] [
    if num = none [num: 1]
    reduce [ v/1 - (w/1 * num)
             v/2 - (w/2 * num) ]
  ]

  scale: func [num] [
    reduce [ v/1 * num 
             v/2 * num ]
  ]
]
