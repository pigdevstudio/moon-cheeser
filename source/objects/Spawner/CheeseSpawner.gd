extends "res://objects/Spawner/Spawner.gd"

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
		cheese.surge(rand_range(min_radius, max_radius))
		cheese.connect("scored", score_handler, "add_score")
		cheese.connect("tree_exited", self, "_on_cheese_tree_exited")
		emit_signal("spawned", cheese)

func set_spread(value):
	spread = clamp(value, 0, 180)
	
func _on_cheese_tree_exited():
	if get_child_count() - 2 > 0:
		return
	queue_free() 