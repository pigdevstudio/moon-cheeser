extends "res://actors/Astromouse/actions/strategies/JumpStrategy.gd"

func get_direction(kinematic_actor):
	var direction = Vector2(0, -1)
	direction = direction.rotated(kinematic_actor.rotation)
	return direction
