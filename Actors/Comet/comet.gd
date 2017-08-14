extends "res://Actors/abstract_space_body.gd"


func _kill_player(collider):
	collider.emit_signal("died")