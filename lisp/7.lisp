(defparameter *nodes* '((living-room (you are in the living-room. a wizard is snoring loudly on the couch.))
    (garden (you are in a beautiful garden. there is a well in front of you.))
    (attic (you are in the attic. there is a giant welding torch in the corner.))))

(defun dot-name (exp)
    (substitute-if #\_ (complement #'alphanumericp) (prin1-to-string exp)))

(defparameter *max-label-length* 30)
(defun dot-label (exp)
    (if exp
        (let ((s (write-to-string exp :pretty nil)))
            (if (> (length s) *max-label-length*)
                (concatenate 'string (subseq s 0 (- *max-label-length* 3)) "...")
                s))
        ""))

(defun nodes->dot (nodes)
    (mapc (lambda (node)
        (fresh-line)
        (princ (dot-name (car node)))
        (princ "[label=\"")
        (princ (dot-label node))
        (princ "\"];"))
    nodes))

(defun edges->dot (edges)
    (mapc 