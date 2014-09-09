(def config {:size 10, :name 'dave, :friends ['charles 'nancy]})

(spit "out.clj" config)

(slurp "out.clj")

(def config2 (read-string (slurp "out.clj")))

config2

(= config config2)
