#!/usr/bin/env python

import rospy
import tf
from tf import TransformListener
from geometry_msgs.msg import PoseStamped

def onNewTransform(pose):
    global msg
    global pub
    global firstTransform

    msg.header.frame_id = pose.header.frame_id
    msg.header.stamp = pose.header.stamp
    msg.header.seq += 1
    msg.pose.position.x = pose.pose.position.x
    msg.pose.position.y = pose.pose.position.y
    msg.pose.position.z = pose.pose.position.z
    msg.pose.orientation.x = pose.pose.orientation.x
    msg.pose.orientation.y = pose.pose.orientation.y
    msg.pose.orientation.z = pose.pose.orientation.z
    msg.pose.orientation.w = pose.pose.orientation.w
    pub.publish(msg)


if __name__ == '__main__':
    rospy.init_node('publish_external_position_vrpn', anonymous=True)
    topic = rospy.get_param("~topic", "/vrpn_client_node/bebop1/pose")
    world = rospy.get_param("~frame_id", "world")
    child_frame = rospy.get_param("~child_frame_id", "bebop1")

    firstTransform = True

    msg = PoseStamped()
    msg.header.seq = 0
    msg.header.stamp = rospy.Time.now()
    print("messages")
    # onNewTransform(world, child_frame)
    rospy.Subscriber(topic, PoseStamped, onNewTransform)

    pub = rospy.Publisher("external_pose", PoseStamped, queue_size=1)
    rospy.spin()
