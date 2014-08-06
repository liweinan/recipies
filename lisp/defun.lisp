(defparameter *fn* (let ((count 0)) #'(lambda () (setf count (1+ count)))))

(let ((count 0))
    (list
        #'(lambda () (incf count))
        #'(lambda () (decf count))
        #'(lambda () count)))

(defun foo (x) (setf x 10))
(let ((y 20))
    (foo y)
    (print y))
