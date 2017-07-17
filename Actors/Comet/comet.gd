extends "res://Actors/abstract_space_body.gd"


func _fixed_process(delta):
	if is_colliding():
		if get_collider().is_in_group("moon"):
			var n = get_collision_normal()
			var pos = get_collision_pos()
			_spawn_crater(pos)
		queue_free()

func _spawn_crater(p):
		var c = load("res://Objects/Crater/Crater.tscn").instance()
		get_collider().get_node("Sprite").add_child(c)
		c.set_global_pos(p)
		c.set_rot(c.get_angle_to(get_collider().get_pos()))