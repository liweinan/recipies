(def make-list2+ #(list %1 %2 %&))

(make-list2+ 1 2 3 4 5)

(defn down [x]
  (when (pos? x)
    (println x)
    (recur (dec x))))