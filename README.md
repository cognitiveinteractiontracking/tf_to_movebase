# tf_to_movebase
A node to let a robot drive to a certain tf

## Example

`rosrun tf_to_movebase tf_to_movebase_node _action_topic:=/4/move_base _tf_name_target:=/4/rest _max_duration:=100 __name:=tf_to_movebase_node`

## Common usage of scripts

1. Run any mapping with Rviz visualization
1. Run a `rostopic echo points` on the Rviz topic which publishes geometry_msgs/PointStamped (e.g. `rostopic echo clicked_point | tee /tmp/cliecked_points.txt`)
1. Use the click_point tool to select certain goal locations for the robot
1. Format the output via `format_point.sh /tmp/cliecked_points.txt`
1. Adapt the `example.sh` script accordingly, to let the robot drive to every location, one after another

## Arguments

* `action_topic`: Topic for sending the action
* `tf_name_target`: Target tf frame which will be approached
* `max_duration`: Time in seconds until the node finishes w/o waiting for the action reply
