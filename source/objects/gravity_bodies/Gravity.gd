extends Node2D

export (float) var acceleration = 50.0

func apply(space_kinematic_body):
	var position_remainder = (global_position - space_kinematic_body.global_position)
	var direction = position_remainder.normalized()
	space_kinematic_body.velocity += direction * (acceleration * get_physics_process_delta_time())
