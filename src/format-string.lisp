(defpackage format-string
  (:use #:cl
	#:named-readtables)
  (:export #:syntax
	   #:parse-format-string))

(in-package #:format-string)

(defun read-until (stream until-char)
  (let (accumulator done)

    (flet ((finished-p (c)
	   (cond
	     ((char= c until-char) t)
	     ((char= c #\`)
	      (setf done t)
	      t)
	     (t nil))))

      (loop for char = (read-char stream)
	    while (not (or (null char) (finished-p char)))
	    do (push char accumulator))

      (values (coerce (nreverse accumulator) 'string) done))))

(defun read-consuming-pair (stream start-char stop-char)
  (if (char= start-char (read-char stream))
      (read-until stream stop-char)
      (error "Stream didn't start with ~C" start-char)))

(defun parse-format-string (stream char &optional count)
  (declare (ignorable char count))
  (multiple-value-bind (format-string arglist) (collect-format-arguments stream)
      `(format nil ,format-string ,@arglist)))

(defun collect-format-arguments (stream)
  (let (format-string-parts argument-forms)
    (loop
      for (subseq done) = (multiple-value-list (read-until stream #\$))
      do (push subseq format-string-parts)
      when (let ((peeked-char (peek-char nil stream nil nil)))
	     (and (not (null peeked-char)) (char= peeked-char #\{)))
	do (progn
	     (push (read-from-string (string-upcase (read-consuming-pair stream #\{ #\}))) argument-forms)
	     (push "~A" format-string-parts))
      until done)
    (values (apply #'concatenate 'string (nreverse format-string-parts))
	    (nreverse argument-forms))))

(defreadtable syntax
  (:merge :standard)
  (:dispatch-macro-char #\# #\` #'parse-format-string))
