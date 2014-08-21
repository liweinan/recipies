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

(defun directed-edges (node edge-list)
    (remove-if-not (lambda (x)
                        (eql (car x) node))
                    edge-list))

(defun get-connected (node edge-list)
    (let ((visited nil))
        (labels ((traverse (node)
            (unless (member node visited)
                (push node visited)
                (mapc (lambda (edge)
                            (traverse (cdr edge)))
                        (directed-edges node edge-list)))))
            (traverse node))
        visited))

(defun find-islands (nodes edge-list)
    (let (islands nil))
        (labels ((find-island (nodes)
                    (let* ((connected (get-connected (get-connected (car nodes) edge-list))
                            (unconnected (set-difference nodes connected)))
                        (push connected islands)
                        (when unconnected
                            (find-island unconnected)))))
            (find-island nodes))
        islands))

(defun connect-with-bridges (islands)
    (when (cdr islands)
        (append (edge-pair (caar islands) (caadr islands))
                (connect-with-bridges (cdr islands)))))

(defun connect-all-islands (nodes edge-list)
    (append (connect-with-bridges (find-islands nodes edge-list)) edge-list))

(defun make-city-edges ()
    (let* (
            (nodes (loop for i from 1 to *node-num* collect i))
            (edge-list (connect-all-islands nodes (make-edge-list)))
            (cops (remove-if-not (lambda (x) (zerop (random *cop-odds*))) edge-list)))
        (add-cops (edges-to-alist edge-list) cops)))

(defun add-cops (edge-alist edges-with-cops)
    (mapcar (lambda (x)
        (let ((node1 (car x)) (node1-edges (cdr x)))
            (cons node1 (mapcar 
                            (lambda (edge) 
                                (let ((node2 (car edge)))
                                    (if (intersection (edge-pair node1 node2)
                                        edges-with-cops
                                        :test #'equal)
                                    (list node2 'cops)
                                edge)))
                        node1-edges))))
                edge-alist))



