# format-string

[![Build Status](https://travis-ci.org/fisxoj/format-string.svg?branch=master)](https://travis-ci.org/fisxoj/format-string)
[![Coverage Status](https://coveralls.io/repos/github/fisxoj/format-string/badge.svg?branch=master)](https://coveralls.io/github/fisxoj/format-string?branch=master)

Templated strings for common lisp.

```lisp
(let ((name "format-string")
      (use "templated strings")
      (how-many "as many as you want"))

  #`${name} is a package implementing ${use} as a reader macro.
You can insert one, two, or ${how-many} variables into a string so that it's
arguably more readable than a format string in some circumstances.`)

; => "format-string is a package implementing templated strings as a reader macro.
; You can insert one, two, or as many as you want variables into a string so that it's
; arguably more readable than a format string in some circumstances."
```

## Using in your project

Probably the sanest way is to use named readtables, like so:
```lisp
(named-readtables:in-readtable format-string:syntax)

(defvar potato-type "yukon")

(defvar exclamation #`I love ${potato-type} potatoes!`)
```

But you can also bind the function to a macro dispatcher

```lisp
(set-dispatch-macro-character #\# #\` #'format-string:parse-format-string)
```
