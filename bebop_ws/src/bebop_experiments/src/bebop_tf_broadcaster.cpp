//
// Created by chris on 7/19/20.
//
#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <geometry_msgs/PoseStamped.h>
std::string bebop_name;

void poseCallback(const geometry_msgs::PoseStamped::ConstPtr& msg){
    ROS_INFO("TF CALL BACK");
    static tf::TransformBroadcaster br;
    tf::Transform transform;
    transform.setOrigin(tf::Vector3(msg->pose.position.x, msg->pose.position.y, msg->pose.position.z));
    tf::Quaternion q;
    q.setRotation(tf::Vector3(msg->pose.orientation.x, msg->pose.orientation.y, msg->pose.orientation.z), tfScalar(msg->pose.orientation.w));
    transform.setRotation(q);
    br.sendTransform(tf::StampedTransform(transform, ros::Time::now(), bebop_name, "odom"));
}

int main(int argc,char** argv){
    ros::init(argc, argv, "bebop_tf_broadcaster");
    ros::NodeHandle node;
//std::string bebop_name;
    node.getParam("frame", bebop_name);
    ros::Subscriber sub = node.subscribe(bebop_name + "/external_pose", 10, &poseCallback);
    ros::spin();
    return 0;
};
