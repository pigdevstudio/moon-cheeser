extends "res://actors/astromouse/actions/strategies/JumpStrategy.gd"

func get_direction(space_space_kinematic_body):
	var direction = Vector2(0, -1)
	direction = direction.rotated(space_space_kinematic_body.rotation)
	return direction
