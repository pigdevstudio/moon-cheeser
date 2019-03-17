extends Tween

export (NodePath) var root_node

func _ready():
	root_node = get_node(root_node)

func pulse():
	if is_active():
		return
	interpolate_property(root_node, "scale", root_node.scale, 
			root_node.scale + Vector2(0.25, 0.25), 0.5,
			TRANS_BACK, EASE_OUT)
	start()
	yield(self, "tween_completed")

	interpolate_property(root_node, "scale", root_node.scale,
			root_node.scale - Vector2(0.25, 0.25), 0.5,
			TRANS_BACK, EASE_OUT)
	start()
