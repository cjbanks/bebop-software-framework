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
        , m_pubCfs()
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
        , m_pidZ1(
            get(n, "PIDs/Z/kp1"),
            get(n, "PIDs/Z/kd1"),
            get(n, "PIDs/Z/ki1"),
            get(n, "PIDs/Z/minOutput1"),
            get(n, "PIDs/Z/maxOutput1"),
            get(n, "PIDs/Z/integratorMin1"),
            get(n, "PIDs/Z/integratorMax1"),
            "z1")
        , m_pidYaw(
            get(n, "PIDs/Yaw/kp"),
            get(n, "PIDs/Yaw/kd"),
            get(n, "PIDs/Yaw/ki"),
            get(n, "PIDs/Yaw/minOutput"),
            get(n, "PIDs/Yaw/maxOutput"),
            get(n, "PIDs/Yaw/integratorMin"),
            get(n, "PIDs/Yaw/integratorMax"),
            "yaw")
        , m_state(Idle)
        , m_goal()
        , m_diffinput()
        , m_subscribeGoal()
        , m_subscribeDiffFlat()
        , m_serviceTakeoff()
        , m_serviceLand()
        , m_thrust(0)
        , m_startZ(0)
    {
        ros::NodeHandle nh;
        m_pubNav = nh.advertise<geometry_msgs::Twist>("cmd_vel", 1);
        m_pubCfs = nh.advertise<std_msgs::String>("CF_state", 1);
        m_subscribeGoal = nh.subscribe("goal", 1, &Controller::goalChanged, this);
        m_subscribeDiffFlat = nh.subscribe("cmd_diff", 1, &Controller::diffinput, this);
        m_serviceTakeoff = nh.advertiseService("takeoff", &Controller::takeoff, this);
        m_serviceLand = nh.advertiseService("land", &Controller::land, this);
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

    bool takeoff(
        std_srvs::Empty::Request& req,
        std_srvs::Empty::Response& res)
    {
        ROS_INFO("Takeoff requested!");
        m_state = TakingOff;

        tf::StampedTransform transform;
        m_listener.lookupTransform(m_worldFrame, m_frame, ros::Time(0), transform);
        m_startZ = transform.getOrigin().z();

        return true;
    }

    bool land(
        std_srvs::Empty::Request& req,
        std_srvs::Empty::Response& res)
    {
        ROS_INFO("Landing requested!");
        m_state = Landing;

        return true;
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
        m_pidZ1.reset();
        m_pidYaw.reset();
    }

    void iteration(const ros::TimerEvent& e)
    {
        float dt = e.current_real.toSec() - e.last_real.toSec();
        float testheight,k_z;
        std_msgs::String msgcf;

        std::stringstream ss;
        ss << m_state;
        msgcf.data = ss.str();
        m_pubCfs.publish(msgcf);

        switch(m_state)
        {
        case TakingOff:
            {
                ROS_INFO("Taking off!");
                tf::StampedTransform transform;
                m_listener.lookupTransform(m_worldFrame, m_frame, ros::Time(0), transform);
                testheight = transform.getOrigin().z();
                ROS_INFO("Height is %0.2f", testheight);
                if (transform.getOrigin().z() < m_startZ - 0.3 || m_thrust > 50000)
                {
                    pidReset();
                    m_pidZ.setIntegral(m_thrust / m_pidZ.ki());
                    m_state = Intermid;
                    m_thrust = 0;
                }
                else
                {
                    m_thrust += 20000 * dt;
                    geometry_msgs::Twist msg;
                    msg.linear.z = m_thrust;
                    m_pubNav.publish(msg);
                }

            }
            break;
        case Intermid:
            {
                ROS_INFO("Intermid!");
                t_intermid = t_intermid + dt;
                tf::StampedTransform transform;
                m_listener.lookupTransform(m_worldFrame, m_frame, ros::Time(0), transform);

                testheight = transform.getOrigin().z();
                ROS_INFO("Height is %0.2f", testheight);

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

                if (t_intermid < 1)
                {
                    k_z = 0.3;
                }
                else
                {
                    k_z = 1;
                }

                geometry_msgs::Twist msg;
                msg.linear.x = k_z*m_pidX.update(0, targetDrone.pose.position.x);
                msg.linear.y = k_z*m_pidY.update(0.0, targetDrone.pose.position.y);
                msg.linear.z = m_pidZ.update(0.0, targetDrone.pose.position.z);
                msg.angular.z = m_pidYaw.update(0.0, yaw);
                m_pubNav.publish(msg);
                float error;
                error = sqrt(pow(targetDrone.pose.position.x,2)+pow(targetDrone.pose.position.y,2)+pow(targetDrone.pose.position.z,2));
                if (error < 0.1 && t_intermid > 4)
                {
                    pidReset();
                    m_state = Automatic;
                    m_thrust_nom = 49000;
                }
            }
            break;
        case Landing:
            {
                ROS_INFO("landing!");
                t_intermid = t_intermid + dt;
                if (t_intermid > 3.0) {
                    t_intermid = 3.0;
                }
                m_goal.pose.position.z = m_startZ - 0.05;
                tf::StampedTransform transform;
                m_listener.lookupTransform(m_worldFrame, m_frame, ros::Time(0), transform);
                testheight = transform.getOrigin().z();
                ROS_INFO("Height is %0.2f", testheight);

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
                msg.linear.x = m_pidX.update(0, targetDrone.pose.position.x);
                msg.linear.y = m_pidY.update(0.0, targetDrone.pose.position.y);
                msg.linear.z = m_thrust_nom*19.0/20.0;
                msg.angular.z = m_pidYaw.update(0.0, yaw);
                m_pubNav.publish(msg);

                if (transform.getOrigin().z() >= m_startZ - 0.04) {
                    m_state = Idle;
                }
            }
            break;
            // intentional fall-thru
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

                // reset PID when switching to differential flatness based control
                if (m_thrust_nom == 49000 && m_diffinput.linear.z != 49000)
                {
                    m_thrust_nom = m_diffinput.linear.z;
                    pidReset();
                }

                geometry_msgs::Twist msg;
                msg.linear.x = m_diffinput.linear.x + m_pidX.update(0, targetDrone.pose.position.x);
                msg.linear.y = m_diffinput.linear.y + m_pidY.update(0.0, targetDrone.pose.position.y);
                msg.linear.z = m_diffinput.linear.z + m_pidZ1.update(0.0, targetDrone.pose.position.z);
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
        TakingOff = 2,
        Landing = 3,
        Intermid = 4,
    };

private:
    std::string m_worldFrame;
    std::string m_frame;
    ros::Publisher m_pubNav;
    ros::Publisher m_pubCfs;
    tf::TransformListener m_listener;
    PID m_pidX;
    PID m_pidY;
    PID m_pidZ;
    PID m_pidZ1;
    PID m_pidYaw;
    State m_state;
    geometry_msgs::PoseStamped m_goal;
    geometry_msgs::Twist m_diffinput;
    ros::Subscriber m_subscribeGoal;
    ros::Subscriber m_subscribeDiffFlat;
    ros::ServiceServer m_serviceTakeoff;
    ros::ServiceServer m_serviceLand;
    float m_thrust;
    float m_startZ;
    float t_intermid = 0;
    float m_thrust_nom=49000;
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
  double frequency;
  n.param("frequency", frequency, 50.0);

  Controller controller(worldFrame, frame, n);
  controller.run(frequency);

  return 0;
}
