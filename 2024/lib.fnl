(local lib {})


(fn lib.iter-table [t]
  "Creates iterator over the table"
  (var current 0)
  (fn [] 
    (set current (+ 1 current))
    (. t current)))

(fn force-iterator [table-or-iterator]
  (local T (type table-or-iterator))
  (if 
    (= "table" T) (lib.iter-table table-or-iterator)
    (= "function" T) table-or-iterator
    (fn [] nil)))

(fn lib.zip [a b]
  "Takes two arrays or iterators and returns an iterator that generates subsequent pairs"
  (local next-a (force-iterator a))
  (local next-b (force-iterator b))
  (fn []
    (let [f (next-a)
          s (next-b)]
      (when (and f s)
        [f s]))))

(fn lib.zip2 [...]
  "This doesn't work yet!"
  (local iterators 
    (lib.collect 
      (lib.map (fn [x] (print x) (force-iterator x)) ...)))
  
  (fn []
    (print ((. iterators 1)))
    (let [tuple (->> iterators 
                     (lib.map (fn [iter] (iter)))
                     (lib.collect))]
      (print tuple)
      (when (and (unpack tuple))
        tuple))))

(fn lib.map [f t]
  "Creates iterator with function f applied to subsequent values from t"
  (local iter (force-iterator t))
  (fn [] (let [x (iter)] (when x (f x)))))

(fn lib.reduce [f t]
  "Reduces values of table/iterator t with function f"
  (local iter (force-iterator t))
  (var result (iter))
  (each [el iter]
    (set result (f result el)))
  result)

(fn lib.sum [t] (lib.reduce (fn [a b] (+ a b)) t))

(fn lib.collect [iterator]
  "Collects iterator to a table. If supplied with table, copies it to a new one"
  (local result [])
  (each [el (force-iterator iterator)]
    (table.insert result el))
  result)

lib
