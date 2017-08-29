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