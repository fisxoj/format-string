(asdf:defsystem format-string-test
  :depends-on ("prove"
	       "format-string")
  :defsystem-depends-on ("prove-asdf")
  :pathname #P"t/"
  :components ((:test-file "format-string"))
  :perform (test-op (op c)
		    (uiop:symbol-call (find-package :prove) :run c)))
