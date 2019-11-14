// ROS
#include <ros/ros.h>
#include <string>
#include <iostream>
// #include <chores/DoDishesAction.h> // Note: "Action" is appended
#include <actionlib/client/simple_action_client.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <geometry_msgs/PoseStamped.h>
#include <tf/transform_listener.h>

typedef actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> MoveBaseClient;

std::string tfNameTarget;
std::string tfNameSource;
std::string actionTopic;
double maxDuration;

int main(int argc, char **argv)
{
  // ROS
  ros::init(argc, argv, "tf_to_movebase");
  ros::NodeHandle n("~");

  n.param<std::string>("tf_name_target", tfNameTarget, "0/pose");
  n.param<std::string>("tf_name_source", tfNameSource, "map"); // Optional, it just has to be a frame that exists in the tree
  n.param<std::string>("action_topic", actionTopic, "/3/move_base");
  n.param<double>("max_duration", maxDuration, 15);

  ROS_INFO("This node sends a defined TF as goal position and waits until the action server replies.");

  // The tf part to get the pose
  tf::TransformListener listener;
  tf::StampedTransform transform;
  geometry_msgs::PoseStamped pose;
  ros::Duration(1.0).sleep();
  listener.waitForTransform( tfNameSource, tfNameTarget, ros::Time(0), ros::Duration(1.0)); 
  try{
    listener.lookupTransform(tfNameSource, tfNameTarget, ros::Time(0), transform);  
    pose.header.stamp = ros::Time::now();
    pose.header.frame_id = tfNameSource;
    pose.pose.position.x = transform.getOrigin().getX();
    pose.pose.position.y = transform.getOrigin().getY();
    pose.pose.position.z = transform.getOrigin().getZ();
    pose.pose.orientation.x = transform.getRotation().getX();
    pose.pose.orientation.y = transform.getRotation().getY();
    pose.pose.orientation.z = transform.getRotation().getZ();
    pose.pose.orientation.w = transform.getRotation().getW();

    // tf::poseStampedTFToMsg(grasp_tf_pose, msg);
    MoveBaseClient ac(actionTopic, true);
    //wait for the action server to come up
    while(!ac.waitForServer(ros::Duration(5.0))){
      ROS_INFO("Waiting for the move_base action server to come up");
    }

    move_base_msgs::MoveBaseGoal goal;
    goal.target_pose = pose;

    ROS_INFO("Sending goal");
    ac.sendGoal(goal);
    ac.waitForResult(ros::Duration(maxDuration));
    if(ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED) {
      ROS_INFO("Hooray, the base moved");
      return 0;
    } else {
      ROS_INFO("The base failed to move for some reason");
      return -1;
    }
  }
  catch (tf::TransformException ex){
    ROS_ERROR("%s",ex.what());
  }

  return -1;
}
