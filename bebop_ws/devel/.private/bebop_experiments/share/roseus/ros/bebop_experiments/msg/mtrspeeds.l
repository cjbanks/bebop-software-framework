;; Auto-generated. Do not edit!


(when (boundp 'bebop_experiments::mtrspeeds)
  (if (not (find-package "BEBOP_EXPERIMENTS"))
    (make-package "BEBOP_EXPERIMENTS"))
  (shadow 'mtrspeeds (find-package "BEBOP_EXPERIMENTS")))
(unless (find-package "BEBOP_EXPERIMENTS::MTRSPEEDS")
  (make-package "BEBOP_EXPERIMENTS::MTRSPEEDS"))

(in-package "ROS")
;;//! \htmlinclude mtrspeeds.msg.html


(defclass bebop_experiments::mtrspeeds
  :super ros::object
  :slots (_m_1 _m_2 _m_3 _m_4 ))

(defmethod bebop_experiments::mtrspeeds
  (:init
   (&key
    ((:m_1 __m_1) 0.0)
    ((:m_2 __m_2) 0.0)
    ((:m_3 __m_3) 0.0)
    ((:m_4 __m_4) 0.0)
    )
   (send-super :init)
   (setq _m_1 (float __m_1))
   (setq _m_2 (float __m_2))
   (setq _m_3 (float __m_3))
   (setq _m_4 (float __m_4))
   self)
  (:m_1
   (&optional __m_1)
   (if __m_1 (setq _m_1 __m_1)) _m_1)
  (:m_2
   (&optional __m_2)
   (if __m_2 (setq _m_2 __m_2)) _m_2)
  (:m_3
   (&optional __m_3)
   (if __m_3 (setq _m_3 __m_3)) _m_3)
  (:m_4
   (&optional __m_4)
   (if __m_4 (setq _m_4 __m_4)) _m_4)
  (:serialization-length
   ()
   (+
    ;; float64 _m_1
    8
    ;; float64 _m_2
    8
    ;; float64 _m_3
    8
    ;; float64 _m_4
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _m_1
       (sys::poke _m_1 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _m_2
       (sys::poke _m_2 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _m_3
       (sys::poke _m_3 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _m_4
       (sys::poke _m_4 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _m_1
     (setq _m_1 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _m_2
     (setq _m_2 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _m_3
     (setq _m_3 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _m_4
     (setq _m_4 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get bebop_experiments::mtrspeeds :md5sum-) "4159a6b337f9935f0d25263e50f2c72a")
(setf (get bebop_experiments::mtrspeeds :datatype-) "bebop_experiments/mtrspeeds")
(setf (get bebop_experiments::mtrspeeds :definition-)
      "float64 m_1
float64 m_2
float64 m_3
float64 m_4


")



(provide :bebop_experiments/mtrspeeds "4159a6b337f9935f0d25263e50f2c72a")


