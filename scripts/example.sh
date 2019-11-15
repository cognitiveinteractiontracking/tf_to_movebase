#!/bin/bash


# Create a TF from any 
TF_COMMON="$1" # eg amiro4/odom
ROBOT_PREFIX="$2" # eg amiro

rosrun tf static_transform_publisher -1.81 -0.34 0 0 0 0 ${TF_COMMON} target/0 100 &
rosrun tf static_transform_publisher -1.89 -2.3 0 0 0 0 ${TF_COMMON} target/1 100 &
rosrun tf static_transform_publisher -0.83 -5.19 0 0 0 0 ${TF_COMMON} target/2 100 &
rosrun tf static_transform_publisher 3.92690944672 -3.34068918228 0 0 0 0 ${TF_COMMON} target/3 100 &
rosrun tf static_transform_publisher 3.67792129517 -0.934426307678 0 0 0 0 ${TF_COMMON} target/4 100 &
rosrun tf static_transform_publisher 3.88256835938 1.44574069977 0 0 0 0 ${TF_COMMON} target/5 100 &
rosrun tf static_transform_publisher 1.75352859497 3.57395935059 0 0 0 0 ${TF_COMMON} target/6 100 &
rosrun tf static_transform_publisher -1.09067249298 3.43783569336 0 0 0 0 ${TF_COMMON} target/7 100 &
rosrun tf static_transform_publisher 1.15436983109 -0.621222496033 0 0 0 0 ${TF_COMMON} target/8 100 &

function go() {
rosrun tf_to_movebase tf_to_movebase_node _action_topic:=/${1}/move_base _tf_name_source:=${TF_COMMON} _tf_name_target:=/target/${2} _max_duration:=100 __name:=tf_to_movebase_${1}_${2}
}


function go_4() {
go ${ROBOT_PREFIX}4 1
go ${ROBOT_PREFIX}4 2
go ${ROBOT_PREFIX}4 3
go ${ROBOT_PREFIX}4 4
go ${ROBOT_PREFIX}4 5
go ${ROBOT_PREFIX}4 6
go ${ROBOT_PREFIX}4 7
}

function go_5() {
go ${ROBOT_PREFIX}5 7
go ${ROBOT_PREFIX}5 6
go ${ROBOT_PREFIX}5 8
go ${ROBOT_PREFIX}5 0
go ${ROBOT_PREFIX}5 1
go ${ROBOT_PREFIX}5 2
go ${ROBOT_PREFIX}5 3
go ${ROBOT_PREFIX}5 4
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

