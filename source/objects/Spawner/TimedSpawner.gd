extends "res://objects/Spawner/Spawner.gd"

export (float) var min_spawn_time = 1.0
export (float) var max_spawn_time = 3.0 

func _ready():
	reset_timer()

func reset_timer():
	var timer = $Timer
	
	timer.wait_time = rand_range(min_spawn_time, max_spawn_time)
	timer.start()
