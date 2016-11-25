#|
  This file is a part of caveman-jscl project.
  Copyright (c) 2016 peccu (peccul@gmail.com)
|#

#|
  Author: peccu (peccul@gmail.com)
|#

(in-package :cl-user)
(defpackage caveman-jscl-asd
  (:use :cl :asdf))
(in-package :caveman-jscl-asd)

(defsystem caveman-jscl
  :version "0.1"
  :author "peccu"
  :license "MIT"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "caveman-jscl"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op caveman-jscl-test))))
