extends Node

var space_kinematic_body

func _unhandled_input(event):
	if event.is_action_pressed("jump"):
		$Jump.apply(space_kinematic_body)
	elif event.is_action_released("jump"):
		var velocity = space_kinematic_body.velocity
		var rotation = space_kinematic_body.rotation
		var relative_velocity =  velocity.rotated(rotation)
		
		var is_falling = relative_velocity.y > 0
		
		if not is_falling:
  			$Jump.stop(space_kinematic_body)
 