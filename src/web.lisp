(in-package :cl-user)
(defpackage caveman-jscl.web
  (:use :cl
        :caveman2
        :caveman-jscl.config
        :caveman-jscl.view
        :caveman-jscl.db
        :datafly
        :sxql
        :jscl)
  (:export :*web*))
(in-package :caveman-jscl.web)

;; for @route annotation
(syntax:use-syntax :annot)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;;
;; JSCL
(ql:quickload :jscl)
(load (merge-pathnames "jscl.lisp" (asdf:system-source-directory :jscl)))
(jscl:bootstrap)

;;
;; Routing rules
(defroute "/" ()
  (render #P"index.html"))
(defroute "/lisp/:lisp.js" (&key lisp)
  (let ((js (format nil "~alisp/~a.js" *static-directory* lisp))
        (lisp (format nil "~alisp/~a.lisp" *static-directory* lisp)))
    (when (or (and
               (not (probe-file js))
               (probe-file lisp))
              (< (file-write-date js) (file-write-date lisp)))
      (jscl::compile-application `(,lisp) js))
    (if (probe-file js)
        (render js)
        (throw-code 404))))

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
