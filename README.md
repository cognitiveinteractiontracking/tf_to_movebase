# tf_to_movebase
A node to let a robot drive to a certain tf

## Example

`rosrun tf_to_movebase tf_to_movebase_node _action_topic:=/4/move_base _tf_name_target:=/4/rest _max_duration:=100 __name:=tf_to_movebase_node`

## Arguments

* `action_topic`: Topic for sending the action
* `tf_name_target`: Target tf frame which will be approached
* `max_duration`: Time in seconds until the node finishes w/o waiting for the action reply
