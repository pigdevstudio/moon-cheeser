extends Node2D

export (PackedScene) var spawnling
export (float) var min_spawn_time = 1.0
export (float) var max_spawn_time = 3.0 

func spawn():
	var instance = spawnling.instance()
	instance.global_position = global_rotation
	
	get_parent().add_child(instance)
	reset_timer()

func reset_timer():
	var timer = $Timer
	
	timer.wait_time = rand_range(min_spawn_time, max_spawn_time)
	timer.start()
