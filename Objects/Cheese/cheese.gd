extends StaticBody2D
export var score = 1

func _ready():
	connect("exit_tree", get_parent(), "count_cheeses")

func float_around(offset):
	randomize()
	var t = get_node("Tween")
	t.interpolate_method(self, "set_pos", get_pos(), offset, 4, t.TRANS_ELASTIC, t.EASE_OUT)
	t.start()
	
func increase_score():
	score_handler.set_score(score)
	acheesements.modify_achievement("mooncheeser", 1)
	queue_free()
	
func move_towards(where):
	var t = get_node("Tween")
	var direction = (where - get_global_pos()).normalized()
	var target = get_global_pos() + (Vector2(100, 100) * direction)
	t.interpolate_method(self, "set_global_pos", get_global_pos(), target, 1.0, t.TRANS_BACK, t.EASE_IN_OUT)
	t.start()