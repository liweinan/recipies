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
    (let ((islands nil))
        (labels ((find-island (nodes)
                    (let* ((connected (get-connected (car nodes) edge-list))
                            (unconnected (set-difference nodes connected)))
                        (push connected islands)
                        (when unconnected (find-island unconnected)))))
            (find-island nodes))
        islands))

(defun connect-with-bridges (islands)
    (when (cdr islands)
        (append (edge-pair (caar islands) (caadr islands))
                (connect-with-bridges (cdr islands)))))

(defun connect-all-islands (nodes edge-list)
    (append (connect-with-bridges (find-islands nodes edge-list)) edge-list))

(defun make-city-edges ()
    (let* ((nodes (loop for i from 1 to *node-num* collect i))
            (edge-list (connect-all-islands nodes (make-edge-list)))
            (cops (remove-if-not (lambda (x) (zerop (random *cop-odds*))) edge-list)))
        (add-cops (edges-to-alist edge-list) cops)))

(defun edges-to-alist (edge-list)
    (mapcar (lambda (node1)
                (cons node1 
                    (mapcar (lambda (edge) (list (cdr edge)))
                            (remove-duplicates (directed-edges node1 edge-list) :test #'equal))))
            (remove-duplicates (mapcar #'car edge-list))))

(defun add-cops (edge-alist edges-with-cops)
    (mapcar (lambda (x)
        (let ((node1 (car x)) (node1-edges (cdr x)))
            (cons node1 (mapcar 
                            (lambda (edge) 
                                (let ((node2 (car edge)))
                                    (if (intersection (edge-pair node1 node2) edges-with-cops :test #'equal)
                                        (list node2 'cops)
                                        edge)))
                        node1-edges))))
                edge-alist))

(defun neighbors (node edge-alist)
    (mapcar #'car (cdr (assoc node edge-alist))))

(defun within-one (a b edge-alist)
    (member b (neighbors a edge-alist)))

(defun within-two (a b edge-alist)
    (or (within-one a b edge-alist)
        (some (lambda (x)
            (within-one x b edge-alist))
            (neighbors a edge-alist))))

(defun make-city-nodes (edge-alist)
    (let ((wumpus (random-node))
        (glow-worms (loop for i below *worm-num* 
                            collect (random-node))))
    (loop for n from 1 to *node-num*
        collect (append (list n)
                    (cond ((eql n wumpus) '(wumpus))
                            ((within-two n wumpus edge-alist) '(blood!)))
                    (cond ((member n glow-worms) 
                                '(glow-worm))
                            ((some (lambda (worm) (within-one n worm edge-alist)) glow-worms)
                                '(lights!)))
                    (when (some #'cdr (cdr (assoc n edge-alist))) 
                                '(sirens!))))))

(defun new-game ()
    (setf *congestion-city-edges* (make-city-edges))
    (setf *congestion-city-nodes* (make-city-nodes *congestion-city-edges*))
    (setf *player-pos* (find-empty-node))
    (setf *visited-nodes* (list *player-pos*))
    (draw-city))

(defun find-empty-node ()
    (let ((x (random-node)))
        (if (cdr (assoc x *congestion-city-nodes*))
            (find-empty-node)
            x)))

(defun draw-city ()
    (ugraph->png "city" *congestion-city-nodes* *congestion-city-edges*))

; draw library in below

(defun dot-name (exp)
    (substitute-if #\_ (complement #'alphanumericp) (prin1-to-string exp)))

(defun dot->png (fname thunk)
    (with-open-file (*standard-output*
                        fname
                        :direction :output
                        :if-exists :supersede)
        (funcall thunk))
    (ext:shell (concatenate 'string "dot -Tpng -O " fname)))

(defun graph->png (fname nodes edges)
    (dot->png fname
                (lambda ()
                    (graph->dot nodes edges))))

(defun graph->dot (nodes edges)
    (princ "digraph{")
    (nodes->dot nodes)
    (edges->dot edges)
        (princ "}"))

(defun dot-label (exp)
    (if exp
        (let ((s (write-to-string exp :pretty nil)))
            (if (> (length s) *max-label-length*)
                (concatenate 'string (subseq s 0 (- *max-label-length* 3)) "...")
                s))
            ""))

(defun nodes-dot (nodes)
    (mapc (lambda (node)
            (fresh-line)
            (princ (dot-name (car node)))
            (princ "label=\"")
            (princ (dot-label node))
            (princ "\"];"))
        nodes))

(defun edges->dot (edges)
    (mapc (lambda (node)
            (mapc (lambda (edge)
                (fresh-line)
                (princ (dot-name (car node)))
                (princ "->")
                (princ (dot-name (car edge)))
                (princ "[label=\"")
                (princ (dot-label (cdr edge)))
                (princ "\"];"))
            (cdr node)))
        edges))

; directed graph extension

(defun uedges->dot (edges)
    (maplist (lambda (lst)
                (mapc (lambda (edge)
                            (unless (assoc (car edge) (cdr lst))
                                (fresh-line)
                                (princ (dot-name (caar lst)))
                                (princ "--")
                                (princ (dot-name (car edge)))
                                (princ "[label=\"")
                                (princ (dot-label (cdr edge)))
                                (princ "\"];")))
                            (cdar lst)))
                edges))

(defun ugraph->dot (nodes edges)
    (princ "graph{")
    (nodes->dot nodes)
    (uedges->dot edges)
    (princ "}"))

(defun ugraph->png (fname nodes edges)
    (dot->png fname
        (lambda ()
            (ugraph->dot nodes edges))))


