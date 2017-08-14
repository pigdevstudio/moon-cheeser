extends StaticBody2D

func _ready():
	connect("exit_tree", get_parent(), "count_cheeses")

func float_around():
	randomize()
	var offset = Vector2(rand_range(-50, 50), rand_range(150, 320)) * -1
	var t = get_node("Tween")
	t.interpolate_method(self, "set_pos", get_pos(), get_pos() + offset, 4, t.TRANS_ELASTIC, t.EASE_OUT)
	t.start()
	
func increase_score():
	get_tree().get_nodes_in_group("level")[0].emit_signal("scored", 1 * (settings.get_difficulty() + 1))
	acheesements.modify_achievement("mooncheeser", 1)
	queue_free()