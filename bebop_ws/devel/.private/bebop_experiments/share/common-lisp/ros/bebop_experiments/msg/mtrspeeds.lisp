; Auto-generated. Do not edit!


(cl:in-package bebop_experiments-msg)


;//! \htmlinclude mtrspeeds.msg.html

(cl:defclass <mtrspeeds> (roslisp-msg-protocol:ros-message)
  ((m_1
    :reader m_1
    :initarg :m_1
    :type cl:float
    :initform 0.0)
   (m_2
    :reader m_2
    :initarg :m_2
    :type cl:float
    :initform 0.0)
   (m_3
    :reader m_3
    :initarg :m_3
    :type cl:float
    :initform 0.0)
   (m_4
    :reader m_4
    :initarg :m_4
    :type cl:float
    :initform 0.0))
)

(cl:defclass mtrspeeds (<mtrspeeds>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <mtrspeeds>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'mtrspeeds)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name bebop_experiments-msg:<mtrspeeds> is deprecated: use bebop_experiments-msg:mtrspeeds instead.")))

(cl:ensure-generic-function 'm_1-val :lambda-list '(m))
(cl:defmethod m_1-val ((m <mtrspeeds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bebop_experiments-msg:m_1-val is deprecated.  Use bebop_experiments-msg:m_1 instead.")
  (m_1 m))

(cl:ensure-generic-function 'm_2-val :lambda-list '(m))
(cl:defmethod m_2-val ((m <mtrspeeds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bebop_experiments-msg:m_2-val is deprecated.  Use bebop_experiments-msg:m_2 instead.")
  (m_2 m))

(cl:ensure-generic-function 'm_3-val :lambda-list '(m))
(cl:defmethod m_3-val ((m <mtrspeeds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bebop_experiments-msg:m_3-val is deprecated.  Use bebop_experiments-msg:m_3 instead.")
  (m_3 m))

(cl:ensure-generic-function 'm_4-val :lambda-list '(m))
(cl:defmethod m_4-val ((m <mtrspeeds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bebop_experiments-msg:m_4-val is deprecated.  Use bebop_experiments-msg:m_4 instead.")
  (m_4 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <mtrspeeds>) ostream)
  "Serializes a message object of type '<mtrspeeds>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'm_1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'm_2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'm_3))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'm_4))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <mtrspeeds>) istream)
  "Deserializes a message object of type '<mtrspeeds>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'm_1) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'm_2) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'm_3) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'm_4) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<mtrspeeds>)))
  "Returns string type for a message object of type '<mtrspeeds>"
  "bebop_experiments/mtrspeeds")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'mtrspeeds)))
  "Returns string type for a message object of type 'mtrspeeds"
  "bebop_experiments/mtrspeeds")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<mtrspeeds>)))
  "Returns md5sum for a message object of type '<mtrspeeds>"
  "4159a6b337f9935f0d25263e50f2c72a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'mtrspeeds)))
  "Returns md5sum for a message object of type 'mtrspeeds"
  "4159a6b337f9935f0d25263e50f2c72a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<mtrspeeds>)))
  "Returns full string definition for message of type '<mtrspeeds>"
  (cl:format cl:nil "float64 m_1~%float64 m_2~%float64 m_3~%float64 m_4~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'mtrspeeds)))
  "Returns full string definition for message of type 'mtrspeeds"
  (cl:format cl:nil "float64 m_1~%float64 m_2~%float64 m_3~%float64 m_4~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <mtrspeeds>))
  (cl:+ 0
     8
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <mtrspeeds>))
  "Converts a ROS message object to a list"
  (cl:list 'mtrspeeds
    (cl:cons ':m_1 (m_1 msg))
    (cl:cons ':m_2 (m_2 msg))
    (cl:cons ':m_3 (m_3 msg))
    (cl:cons ':m_4 (m_4 msg))
))
