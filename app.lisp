(ql:quickload :caveman-jscl)

(defpackage caveman-jscl.app
  (:use :cl)
  (:import-from :lack.builder
                :builder)
  (:import-from :ppcre
                :scan
                :regex-replace)
  (:import-from :caveman-jscl.web
                :*web*)
  (:import-from :caveman-jscl.config
                :config
                :productionp
                :*static-directory*
                :*base-url*))
(in-package :caveman-jscl.app)

(builder
 (:static
  :path (lambda (path)
          (let ((basepath (regex-replace (format nil "^~a" *base-url*) path "")))
            (if (ppcre:scan "^(?:/images/|/css/|/js/|/robot\\.txt$|/favicon\\.ico$)" basepath)
                basepath
                nil)))
  :root *static-directory*)
 (if (productionp)
     nil
     :accesslog)
 (if (getf (config) :error-log)
     `(:backtrace
       :output ,(getf (config) :error-log))
     nil)
 :session
 (if (productionp)
     nil
     (lambda (app)
       (lambda (env)
         (let ((datafly:*trace-sql* t))
           (funcall app env)))))
 (:mount *base-url* *web*)
 *web*)
