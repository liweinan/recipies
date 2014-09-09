(def vowel? (set "aeiou"))
(defn pig-latin [word]
    (let [first-letter (first word)]
        (if (vowel? first-letter)
            (str word "ay")
            (str (subs word 1) first-letter "ay"))))

(println (pig-latin "red"))
(println (pig-latin "orange"))
(println (pig-latin "purple"))

(println (pig-latin "hello") "," (pig-latin "martian"))

