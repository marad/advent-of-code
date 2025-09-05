comment {
  Contains helpers for defining parsing grammars
}

Red [Title: "Grammar"]

grammar: context [
  digit: charset "0123456789"
  integer: [some digit]
]
