extends Area2D

onready var test = float_around()

func float_around():
	randomize()
	var offset = Vector2(rand_range(-50, 50), rand_range(100, 300)) * -1
	var t = get_node("Tween")
	t.interpolate_method(self, "set_pos", get_pos(), get_pos() + offset, 4, t.TRANS_ELASTIC, t.EASE_OUT)
	t.start()