extends Node

var kinematic_actor

func _unhandled_input(event):
	if event.is_action_pressed("jump"):
		$Jump.apply(kinematic_actor)
