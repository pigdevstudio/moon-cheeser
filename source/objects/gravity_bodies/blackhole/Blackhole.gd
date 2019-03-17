extends "res://objects/gravity_bodies/GravityBody.gd"

func _on_Singularity_body_entered(body):
	if body.has_method("die"):
		body.die()

func set_astromouse(new_astromouse):
	.set_astromouse(new_astromouse)
	var astromouse_actions = new_astromouse.get_action_node()
	astromouse_actions.set_process_unhandled_input(false)

func queue_free():
	var astromouse_actions = astromouse.get_action_node()
	astromouse_actions.set_process_unhandled_input(true)
	.queue_free()
