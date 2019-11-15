#!/bin/bash

rosrun tf static_transform_publisher -1.89 -2.3 0 0 0 0 amiro4/odom target/0 100 &
rosrun tf static_transform_publisher -0.83 -5.19 0 0 0 0 amiro4/odom target/1 100 &
rosrun tf static_transform_publisher 3.92690944672 -3.34068918228 0 0 0 0 amiro4/odom target/2 100 &
rosrun tf static_transform_publisher 3.67792129517 -0.934426307678 0 0 0 0 amiro4/odom target/3 100 &
rosrun tf static_transform_publisher 3.88256835938 1.44574069977 0 0 0 0 amiro4/odom target/4 100 &
rosrun tf static_transform_publisher 1.75352859497 3.57395935059 0 0 0 0 amiro4/odom target/5 100 &
rosrun tf static_transform_publisher -1.09067249298 3.43783569336 0 0 0 0 amiro4/odom target/6 100 &
rosrun tf static_transform_publisher 1.15436983109 -0.621222496033 0 0 0 0 amiro4/odom target/7 100 &


rosrun tf static_transform_publisher -1.09067249298 3.43783569336 0 0 0 0 amiro5/odom target/0 100 &
rosrun tf static_transform_publisher 1.75352859497 3.57395935059 0 0 0 0 amiro5/odom target/1 100 &
rosrun tf static_transform_publisher 1.15436983109 -0.621222496033 0 0 0 0 amiro5/odom target/2 100 &
rosrun tf static_transform_publisher -1.81 -0.34 0 0 0 0 amiro5/odom target/3 100 &
rosrun tf static_transform_publisher -1.89 -2.3 0 0 0 0 amiro5/odom target/4 100 &
rosrun tf static_transform_publisher -0.83 -5.19 0 0 0 0 amiro5/odom target/5 100 &
rosrun tf static_transform_publisher 3.92690944672 -3.34068918228 0 0 0 0 amiro5/odom target/6 100 &
rosrun tf static_transform_publisher 3.67792129517 -0.934426307678 0 0 0 0 amiro5/odom target/7 100 &

function go() {
rosrun tf_to_movebase tf_to_movebase_node _action_topic:=/${1}/move_base _tf_name_source:=${3} _tf_name_target:=/target/${2} _max_duration:=100 __name:=tf_to_movebase_${1}_${2}
}

function go_4() {
	for IDX in $(seq 0 7); do
		go amiro4 $IDX amiro4/odom
	done
}

function go_5() {
	for IDX in $(seq 0 17); do
		go amiro5 $IDX amiro5/odom
	done
}

go_4 &
go_5 &

# double check if the nodes are running
sleep 2
while rosnode list | grep -q tf_to_movebase; do
	while rosnode list | grep -q tf_to_movebase; do
		sleep 1
		echo tf_to_movebase still running
	done
	sleep 2
done

killall rosmaster
killall static_transform_publisher
killall tf_to_movebase_node
