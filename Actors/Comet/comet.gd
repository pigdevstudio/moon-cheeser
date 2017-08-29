extends "res://Actors/abstract_space_body.gd"

func _kill_player(collider):
	collider.get_node("SFX").play("damage")
	collider.emit_signal("died")