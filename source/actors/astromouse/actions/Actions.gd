extends Node

var kinematic_actor

func _unhandled_input(event):
	if event.is_action_pressed("jump"):
		$Jump.apply(kinematic_actor)
	elif event.is_action_released("jump"):
		var velocity = kinematic_actor.velocity
		var rotation = kinematic_actor.rotation
		var relative_velocity =  velocity.rotated(rotation)
		
		var is_falling = relative_velocity.y > 0
		
		if not is_falling:
  			$Jump.stop(kinematic_actor)
 