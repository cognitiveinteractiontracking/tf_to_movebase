cmake_minimum_required(VERSION 2.8.3)
project(tf_to_movebase)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  nav_msgs
  roscpp
  rospy
  sensor_msgs
  std_msgs
  actionlib_msgs
  move_base_msgs
  geometry_msgs
  std_srvs
  tf
)

add_definitions(-std=c++11)

catkin_package(
#  INCLUDE_DIRS include
 CATKIN_DEPENDS roscpp rospy std_msgs nav_msgs sensor_msgs tf 
# DEPENDS system_lib
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)

add_executable(tf_to_movebase_node src/tf_to_movebase_node.cpp)

target_link_libraries(tf_to_movebase_node
  ${catkin_LIBRARIES}
)
