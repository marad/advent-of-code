(local fennel (require :fennel))
(local lib (require :lib))
(let [ogprint print]
  (fn _G.print [...] (ogprint (fennel.view ...))))


(var correct-count 0)
(each [line (io.lines "day02_test.txt")]
  (local digits (->> (line:gmatch "[0-9]+")
                     (lib.map tonumber)
                     (lib.collect)))
  (print digits)
  (print (< -1 (unpack digits)))
  (if (< -1 (unpack digits))
    (set correct-count (+ 1 correct-count))))

(print correct-count)

