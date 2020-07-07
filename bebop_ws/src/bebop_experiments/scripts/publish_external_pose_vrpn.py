#!/usr/bin/env python

import rospy
import tf
from tf import TransformListener
from geometry_msgs.msg import PoseStamped, TransformStamped

def onNewTransform(world, child_frame):
    global msg
    global pub
    global firstTransform
    listener = TransformListener()
    listener.waitForTransform(world, child_frame, rospy.Time(), rospy.Duration(5.0))

    print("transform")
    print("transform", world)
    t = listener.getLatest.CommonTime(world, child_frame)
    if listener.canTransform(world, child_frame, t):
        position, quat = listener.lookupTransform(world, child_frame, t)
        msg.header.frame_id = world
        msg.header.stamp = rospy.Time.now()
        msg.header.seq += 1
        msg.pose.position.x = position[0]
        msg.pose.position.y = position[1]
        msg.pose.position.z = position[2]
        msg.pose.orientation.x = quat[0]
        msg.pose.orientation.y = quat[1]
        msg.pose.orientation.z = quat[2]
        msg.pose.orientation.w = quat[3]
        pub.publish(msg)


if __name__ == '__main__':
    rospy.init_node('publish_external_position_vicon', anonymous=True)
    topic = rospy.get_param("~topic", "/vicon/bebop1/bebop1")
    world = rospy.get_param("~frame_id", "world")
    child_frame = rospy.get_param("~child_frame_id", "bebop1")

    firstTransform = True

    msg = PoseStamped()
    msg.header.seq = 0
    msg.header.stamp = rospy.Time.now()
    print("messages")
    pub = rospy.Publisher("external_pose", PoseStamped, queue_size=1)
    onNewTransform(world, child_frame)
    # rospy.Subscriber(topic, TransformStamped, onNewTransform)

    rospy.spin()
