(asdf:defsystem "format-string"
  :version (:read-file-form "version.sexp")
  :license "BSD-3-Clause"
  :pathname #P"src/"
  :depends-on ("named-readtables")
  :description "Reader macro for simple format string syntax."
  :components ((:file "format-string"))
  :in-order-to ((test-op (test-op "format-string-test"))))
