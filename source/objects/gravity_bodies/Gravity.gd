extends Node

export (float) var acceleration = 50.0
export (Vector2) var direction = Vector2(0, 1)

func apply(space_space_kinematic_body):
	space_space_kinematic_body.velocity += direction * (acceleration * get_physics_process_delta_time())
