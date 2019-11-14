#!/bin/bash

# 0. Run a `rostopic echo points` on some topics which publishes geometry_msgs/PointStamped
# 1. Pipe the output to $FILE
# 2. Publish points in rviz
# 3. call this script and store the output

FILE="/tmp/point_file.txt"
RATE=100
S="odom"
T_PREFIX="target"
IDX=0

# make newline the only seperator
IFS=$'\n'

for XYZ in $(cat $FILE | grep -E "x:|y:|z:" | cut --bytes=6- | sed 'N;N;s/\n/ /g'); do
  echo "rosrun tf static_transform_publisher $XYZ 0 0 0 $S ${T_PREFIX}/${IDX} $RATE"
  IDX=$((IDX+1))
done
