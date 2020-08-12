
(cl:in-package :asdf)

(defsystem "bebop_experiments-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "mtrspeeds" :depends-on ("_package_mtrspeeds"))
    (:file "_package_mtrspeeds" :depends-on ("_package"))
  ))