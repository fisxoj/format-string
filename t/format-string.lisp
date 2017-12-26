(defpackage format-string-test
  (:use #:cl
	#:prove))

(in-package #:format-string-test)

(named-readtables:in-readtable format-string:syntax)

(plan 2)

(subtest "read-util"
  (with-input-from-string (stream "Something ${potato}")
    (is (format-string::read-until stream #\$) "Something "
	"Reads up to but not including character."))

  (with-input-from-string (stream "Something`")
    (is (format-string::read-until stream #\$) "Something"
	"Also finishes if it encounters #\`")))

(subtest "reader macro"
  (let ((a 5)
	(b "two"))
    (is #`A number ${a} and the word ${b}.`
	"A number 5 and the word two."
	"Macro formats two variables correctly")

    (is #`${a} something` "5 something"
	"Inserts correctly a the beginning of a format string."))

  (is #`${cl:most-positive-fixnum}` (format nil "~A" most-positive-fixnum)
      "Allows package prefixes in format strings."))

(finalize)
