extends "res://Actors/abstract_space_body.gd"


func _fixed_process(delta):
	if is_colliding():
		if get_collider().is_in_group("moon"):
			var crater = load("res://Objects/Crater/Crater.tscn").instance()
			get_collider().get_node("Sprite").add_child(crater)
			crater.set_global_pos(get_collision_pos())
			crater.set_rot(crater.get_angle_to(get_collider().get_pos()))
			
			var c = load("res://Objects/Cheese/Cheese.tscn").instance()
			get_collider().get_node("Sprite").add_child(c)
			c.set_pos(get_collision_pos())
		queue_free()
