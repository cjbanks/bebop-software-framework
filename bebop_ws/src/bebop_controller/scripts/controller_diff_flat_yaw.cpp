#include <ros/ros.h>
#include <tf/transform_listener.h>
#include <std_srvs/Empty.h>
#include <geometry_msgs/Twist.h>
#include "std_msgs/String.h"
#include <math.h>

#include "pid.hpp"

double get(
    const ros::NodeHandle& n,
    const std::string& name) {
    double value;
    n.getParam(name, value);
    return value;
}

class Controller
{
public:

    Controller(
        const std::string& worldFrame,
        const std::string& frame,
        const ros::NodeHandle& n)
        : m_worldFrame(worldFrame)
        , m_frame(frame)
        , m_pubNav()
        , m_listener()
        , m_pidX(
            get(n, "PIDs/X/kp"),
            get(n, "PIDs/X/kd"),
            get(n, "PIDs/X/ki"),
            get(n, "PIDs/X/minOutput"),
            get(n, "PIDs/X/maxOutput"),
            get(n, "PIDs/X/integratorMin"),
            get(n, "PIDs/X/integratorMax"),
            "x")
        , m_pidY(
            get(n, "PIDs/Y/kp"),
            get(n, "PIDs/Y/kd"),
            get(n, "PIDs/Y/ki"),
            get(n, "PIDs/Y/minOutput"),
            get(n, "PIDs/Y/maxOutput"),
            get(n, "PIDs/Y/integratorMin"),
            get(n, "PIDs/Y/integratorMax"),
            "y")
        , m_pidZ(
            get(n, "PIDs/Z/kp"),
            get(n, "PIDs/Z/kd"),
            get(n, "PIDs/Z/ki"),
            get(n, "PIDs/Z/minOutput"),
            get(n, "PIDs/Z/maxOutput"),
            get(n, "PIDs/Z/integratorMin"),
            get(n, "PIDs/Z/integratorMax"),
            "z")
        , m_pidYaw(
            get(n, "PIDs/Yaw/kp"),
            get(n, "PIDs/Yaw/kd"),
            get(n, "PIDs/Yaw/ki"),
            get(n, "PIDs/Yaw/minOutput"),
            get(n, "PIDs/Yaw/maxOutput"),
            get(n, "PIDs/Yaw/integratorMin"),
            get(n, "PIDs/Yaw/integratorMax"),
            "yaw")
        , m_goal()
        , m_diffinput()
        , m_subscribeGoal()
        , m_subscribeDiffFlat()
        , m_state(Idle)
        , m_thrust(0)
        , m_startZ(0)
    {
        ros::NodeHandle nh;
        m_pubNav = nh.advertise<geometry_msgs::Twist>("cmd_vel", 1);
        m_subscribeGoal = nh.subscribe("goal", 1, &Controller::goalChanged, this);
        m_subscribeDiffFlat = nh.subscribe("cmd_diff", 1, &Controller::diffinput, this);
    }

    void run(double frequency)
    {
        ros::NodeHandle node;
        ros::Timer timer = node.createTimer(ros::Duration(1.0/frequency), &Controller::iteration, this);
        ros::spin();
    }

private:
    void goalChanged(
        const geometry_msgs::PoseStamped::ConstPtr& msg)
    {
        m_goal = *msg;
    }

    void diffinput(const geometry_msgs::Twist::ConstPtr& msg)
    {
        m_diffinput = *msg;
    }

    void getTransform(
        const std::string& sourceFrame,
        const std::string& targetFrame,
        tf::StampedTransform& result)
    {
        m_listener.lookupTransform(sourceFrame, targetFrame, ros::Time(0), result);
    }

    void pidReset()
    {
        m_pidX.reset();
        m_pidY.reset();
        m_pidZ.reset();
        m_pidYaw.reset();
    }

    void iteration(const ros::TimerEvent& e)
    {
        float dt = e.current_real.toSec() - e.last_real.toSec();
        float testheight, k_z;

        switch(m_state)
        {
        case Automatic:
            {
                ROS_INFO("Automatic!");
                tf::StampedTransform transform;
                m_listener.lookupTransform(m_worldFrame, m_frame, ros::Time(0), transform);

                testheight = transform.getOrigin().z();

                geometry_msgs::PoseStamped targetWorld;
                targetWorld.header.stamp = transform.stamp_;
                targetWorld.header.frame_id = m_worldFrame;
                targetWorld.pose = m_goal.pose;

                geometry_msgs::PoseStamped targetDrone;
                m_listener.transformPose(m_frame, targetWorld, targetDrone);

                tfScalar roll, pitch, yaw;
                tf::Matrix3x3(
                    tf::Quaternion(
                        targetDrone.pose.orientation.x,
                        targetDrone.pose.orientation.y,
                        targetDrone.pose.orientation.z,
                        targetDrone.pose.orientation.w
                    )).getRPY(roll, pitch, yaw);

                geometry_msgs::Twist msg;
                msg.linear.x = m_diffinput.linear.x + m_pidX.update(0, targetDrone.pose.position.x);
                msg.linear.y = m_diffinput.linear.y + m_pidY.update(0.0, targetDrone.pose.position.y);
                msg.linear.z = m_diffinput.linear.z + m_pidZ.update(0.0, targetDrone.pose.position.z);
                msg.angular.z = m_diffinput.angular.z + m_pidYaw.update(0.0, yaw);
                
                // note vx is -pitch, vy is roll, see cf server cpp code for detail
                //ROS_INFO("Diff Flat Roll is: %0.2f", m_diffinput.linear.y);
                //ROS_INFO("Diff Flat Pitch is: %0.2f", - m_diffinput.linear.x);
                //ROS_INFO("Diff Flat Thrust is: %0.2f", m_diffinput.linear.z);
                //ROS_INFO("Current Roll is: %0.2f", msg.linear.y);
                //ROS_INFO("Current Pitch is: %0.2f", -msg.linear.x);
                //ROS_INFO("Current Thrust is: %0.2f", msg.linear.z);
                m_pubNav.publish(msg);
            }
            break;
        case Idle:
            {
                ROS_INFO("IDLE");
                tf::StampedTransform transform;
                m_listener.lookupTransform(m_worldFrame, m_frame, ros::Time(0), transform);
                testheight = transform.getOrigin().z();
                ROS_INFO("Height is %0.2f", testheight);
                if (transform.getOrigin().z() < m_startZ - 0.3 || m_thrust > 50000)
                {
                    m_state = Automatic;
                }
                geometry_msgs::Twist msg;
                m_pubNav.publish(msg);
            }
            break;
        }
    }

private:

    enum State
    {
        Idle = 0,
        Automatic = 1,
    };

private:
    std::string m_worldFrame;
    std::string m_frame;
    ros::Publisher m_pubNav;
    tf::TransformListener m_listener;
    PID m_pidX;
    PID m_pidY;
    PID m_pidZ;
    PID m_pidYaw;
    State m_state;
    geometry_msgs::PoseStamped m_goal;
    geometry_msgs::Twist m_diffinput;
    ros::Subscriber m_subscribeGoal;
    ros::Subscriber m_subscribeDiffFlat;
    float m_startZ;
    float m_thrust;
    float t_intermid = 0;
    float m_thrust_nom=4.9;
};

int main(int argc, char **argv)
{
  ros::init(argc, argv, "controller");

  // Read parameters
  ros::NodeHandle n("~");
  std::string worldFrame;
  n.param<std::string>("worldFrame", worldFrame, "/world");
  std::string frame;
  n.getParam("frame", frame);
    std::cout<<"FRAME :"<< frame << std::endl;
  double frequency;
  n.param("frequency", frequency, 50.0);

  Controller controller(worldFrame, frame, n);
  controller.run(frequency);

  return 0;
}
