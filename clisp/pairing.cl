(defstruct node
	(key) (chld nil))

(defun link (lhs rhs)
	(if (null lhs)
		rhs
		(if (null rhs)
			lhs
			(if (< (node-key lhs) (node-key rhs))
				(make-node :key (node-key lhs) :chld (cons rhs (node-chld lhs)))
				(make-node :key (node-key rhs) :chld (cons lhs (node-chld rhs)))))))

(defun merge_chld (lst)
	(if (< (list-length lst) 2)
		(car lst)
		(link (link (car lst) (cadr lst)) (merge_chld (cddr lst)))))

(defun htop (nd)
	(node-key nd))

(defun hpop (nd)
	(merge_chld (node-chld nd)))

(defun hinsert (val nd)
	(link nd (make-node :key val)))

(defun main ()
	(setq heap nil)
	(loop
		for line = (read-line nil nil nil)
		while line do
		(case (parse-integer line :end 1)
			(0 (setq heap (hinsert (parse-integer line :start 1) heap)))
			(1 (format t "~d~%" (htop heap)))
			(2 (setq heap (hpop heap))))))

(main)
