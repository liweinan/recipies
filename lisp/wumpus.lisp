(load "graph-util")

(defparameter *congestion-city-nodes* nil)
(defparameter *congestion-city-edges* nil)
(defparameter *visited-nodes* nil)
(defparameter *node-num* 30)
(defparameter *edge-num* 45)
(defparameter *worm-num* 3)
(defparameter *cop-odds* 15)

(defun random-node ()
    (1+ (random *node-num*)))

(defun edge-pair (a b)
    (unless (eql a b)
        (list (cons a b) (cons b a))))

(defun make-edge-list ()
    (apply #'append (loop repeat *edge-num*
            collect (edge-pair (random-node) (random-node)))))

(defun direct-edges (node edge-list)
    (remove-if-not (lambda(x)
        (eql (car x) node)
        edge-list)))

(defun get-connected (node edge-list)
    (let ((visited nil))
        (labels ((traverse (node)
            (unless (member node visited)
                (push node visied)
                (mapc (lambda (edge)
                    (traverse (cdr edge)))
                (direct-edges node edge-list)))))
        (traverse node))
        visited))

(defun find-islands (nodes edge-list)
    (let ((islands nil)))
    )