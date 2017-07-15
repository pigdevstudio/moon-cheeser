extends "res://Actors/abstract_space_body.gd"

func _on_area_enter( area ):
	if area.is_in_group("player"):
		var i = load("res://Actors/Astromouse/StarMouse.tscn").instance()
		i.set_pos(get_pos())
		get_parent().add_child(i)
		area.get_parent().get_parent().remove_child(area.get_parent())
		queue_free()