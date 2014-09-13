(class (hash-map :a 1))

(class (seq (hash-map :a 1)))

(class (seq (keys (hash-map :a 1))))

(class (keys (hash-map :a 1)))

(def make-set
  (fn [x y]
    (println "Making a set")
    #{x y}))

(defn make-set2
  "Description of functin"
  [x y]
  (println "Making a set")
  #{x y})

(defn arity2+ [first second & more]
  (vector first second more))

(arity2+ 1 2 3 4)
