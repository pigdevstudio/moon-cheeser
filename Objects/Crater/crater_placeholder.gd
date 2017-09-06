extends Node2D

func _ready():
	randomize()

func count_cheeses():
	if get_child_count() <= 0:
		queue_free()
		
func spawn_cheeses(type):
	if type == 0:
		var max_cheeses = round(rand_range(4, 8))
		for i in range(0,max_cheeses):
			var c = load("res://Objects/Cheese/Cheese.tscn").instance()
			add_child(c)
			c.float_around(c.get_pos() + Vector2(rand_range(-50, 50), rand_range(150, 320)) * -1)
	elif type == 1:
		var max_cheeses = round(rand_range(4, 8))
		for i in range(0,max_cheeses):
			var c = load("res://Objects/Cheese/Cheese.tscn").instance()
			add_child(c)
			c.float_around(c.get_pos() + Vector2(rand_range(-100, 100), rand_range(-100, 100)))
	elif type == 2:
		var c = load("res://Objects/Cheese/Cheddar.tscn").instance()
		add_child(c)
		c.float_around(c.get_pos() + Vector2(rand_range(-20, 20), rand_range(-20, 20)))