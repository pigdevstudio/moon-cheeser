extends Node

export (float) var acceleration = 50.0
export (Vector2) var direction = Vector2(0, 1)

func apply(kinematic_actor):
	kinematic_actor.velocity += direction * (acceleration * get_physics_process_delta_time())
