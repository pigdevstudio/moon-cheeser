extends "res://Actors/abstract_space_body.gd"

func _on_area_enter( area ):
	pass

func _on_area_enter_shape( area_id, area, area_shape, self_shape ):
	if self_shape != 0:
		if area.is_in_group("player"):
			var i = load("res://Actors/Astromouse/StarMouse.tscn").instance()
			i.set_pos(get_pos())
			get_parent().add_child(i)
			area.get_parent().get_parent().remove_child(area.get_parent())
		if not area.is_in_group("cheese"):
			queue_free()
