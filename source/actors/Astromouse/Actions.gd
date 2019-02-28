extends Node

var kinematic_actor

func _unhandled_input(event):
	if event.is_action_pressed("jump"):
		$Jump.apply(kinematic_actor)


func _on_KinematicActor_collided(collision):
	if collision.collider.is_in_group("moon"):
		$Jump.reset()
