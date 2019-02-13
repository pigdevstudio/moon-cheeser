extends "res://objects/Spawner/Spawner.gd"

export (int) var min_cheeses = 2
export (int) var max_cheeses = 8

export (float) var spread = 10 setget set_spread

func spawn():
	var cheeses = clamp(randi()%max_cheeses, min_cheeses, max_cheeses)
	for i in cheeses:
		var cheese = spawnling.instance()
		add_child(cheese)
		cheese.rotation_degrees = rand_range(-spread, spread)
		cheese.surge()

func set_spread(value):
	spread = clamp(value, 0, 180)