(format t "Add onion rings for only ~$ dollars more!" 1.5)

(princ (reverse (format nil "Hello, world!")))

;; below two are same
(format t "~10@a" "Hello")
(princ (format nil "~10@a" "Hello"))

(format t "~5,,,'!a" "foo") ;;; foo!
(format t "~,,5,'!a" "foo") ;;; foo!!

(format t "~,4f" 3.1415926) ;;; the second parameter of the ~f control
;;; sequence controls the number of digits displayed after the decimal point.
;;; 3.1416

(progn (princ 22) (terpri) (terpri) (princ 33))
;;; fresh-line will start a new line, but only if the cursor position
;;; in the REPL isn't already at the very front of a line.
(progn (princ 22) (fresh-line) (fresh-line) (princ 33)) ;;; start a new line, if needed

(loop for (a b) in '((1 2) (3 4) (5 6))
            do (format t "a: ~a; b: ~a~%" a b))

(format t "~1t~a ~1t~a~%" "1234" "abcdefghijklmn")

(defun random-str ()
    (nth (random 7) '(1 22 333 4444 55555 666666 77777777))))
(loop repeat 10
    do (format t "~10t~a ~30t~a ~50t~a~%" (random-str) (random-str) (random-str)))

(defun random-animal ()
    (nth (random 5) '("dog" "tick" "tiger" "walrus" "kangaroo")))
(loop repeat 10
    do (format t "~5t~a ~15t~a ~25t~a~%" (random-animal) (random-animal) (random-animal)))

(loop repeat 10
    do (format t "~50<~a~;~a~;~a~>~%" (random-animal) (random-animal) (random-animal)))

(format t "|~{~<|~%|~,33:;~2d ~>~}|" (loop for x below 100 collect x))

; [258]> (or (setf *aaa* nil))
; NIL

(defun say-hello ()
    (princ "Please type your name: ")
    (let ((name (read-line)))
        (princ "Nice to meet you, ")
        (princ name)))
