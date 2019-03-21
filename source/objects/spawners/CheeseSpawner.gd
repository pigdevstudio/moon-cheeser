extends "res://objects/spawners/Spawner.gd"

"""
Spread a random amount of cheeses 
"""

export (int) var min_cheeses = 2
export (int) var max_cheeses = 8

export (float) var spread = 10 setget set_spread
export (float) var min_radius = 50
export (float) var max_radius = 200

func spawn():
	var cheeses = clamp(randi()%max_cheeses, min_cheeses, max_cheeses)
	for i in cheeses:
		var cheese = spawnling.instance()
		add_child(cheese)
		cheese.rotation_degrees = rand_range(-spread, spread)
		cheese.connect("scored", Score, "add_score")
		cheese.connect("tree_exited", self, "_on_cheese_tree_exited")
		surge(cheese, rand_range(min_radius, max_radius))

func surge(cheese, offset_distance):
	var tween = $Tween
	var offset = offset_distance * Vector2(0, -1).rotated(cheese.rotation)
	
	tween.interpolate_property(cheese, "position", cheese.position, 
			cheese.position + offset, 0.5, tween.TRANS_BACK, tween.EASE_OUT)
	tween.start()

func set_spread(value):
	spread = clamp(value, 0, 180)

func _on_cheese_tree_exited():
	if get_child_count() - 2 > 0:
		return
	queue_free() 
