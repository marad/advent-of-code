(local fennel (require :fennel))
(local lib (require :lib))
(let [ogprint print]
  (fn _G.print [...] (ogprint (fennel.view ...))))


(local left [])
(local right [])

(each [line (io.lines "day01.txt")]
  (let [iter (line:gmatch "[0-9]+")]
    (table.insert left (tonumber (iter)))
    (table.insert right (tonumber (iter)))))

(table.sort right)
(table.sort left)

(->> (lib.zip left right)
     (lib.map (fn [[a b]] (math.abs (- a b))))
     (lib.sum)
     (.. "Part 1: ")
     (print))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Part 2

;; Calculate number counts
(local counts {})
(each [number (lib.iter-table right)]
  (let [count (or (. counts number) 0)] 
    (set (. counts number) (+ 1 count))))


;; Calculate sum(L*count[L])
(->> left 
     (lib.map (fn [l] (* l (or (. counts l) 0))))
     (lib.sum)
     (.. "Part 2: ")
     (print))
