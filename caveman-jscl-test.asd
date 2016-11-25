#|
  This file is a part of caveman-jscl project.
  Copyright (c) 2016 peccu (peccul@gmail.com)
|#

(in-package :cl-user)
(defpackage caveman-jscl-test-asd
  (:use :cl :asdf))
(in-package :caveman-jscl-test-asd)

(defsystem caveman-jscl-test
  :author "peccu"
  :license "MIT"
  :depends-on (:caveman-jscl
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "caveman-jscl"))))
  :description "Test system for caveman-jscl"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
