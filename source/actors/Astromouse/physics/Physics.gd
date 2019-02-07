extends Node

var kinematic_actor

func _physics_process(delta):
	for force in get_children():
		force.apply(get_parent())
