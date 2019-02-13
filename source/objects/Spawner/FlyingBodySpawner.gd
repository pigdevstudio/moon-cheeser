extends "res://objects/Spawner/TimedSpawner.gd"

export (Vector2) var flying_direction = Vector2(1, 0)

func spawn():
	var instance = spawnling.instance()
	
	instance.fly(flying_direction)
	instance.global_position = global_position
	get_parent().add_child(instance)
	reset_timer()
