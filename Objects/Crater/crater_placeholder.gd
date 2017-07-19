extends Node2D

func _ready():
	randomize()
	var max_cheeses = round(rand_range(4, 8))
	for i in range(0,max_cheeses):
		var c = load("res://Objects/Cheese/Cheese.tscn").instance()
		add_child(c)
		c.float_around()

func count_cheeses():
	if get_child_count() <= 0:
		queue_free()