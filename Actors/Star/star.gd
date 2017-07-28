extends "res://Actors/abstract_space_body.gd"

func _ready():
	get_node("Sprite").set_texture(load(skins.star_skin))
func _instance_starmouse(collider):
	var i = load("res://Actors/Astromouse/StarMouse.tscn").instance()
	i.set_pos(get_pos())
	get_parent().add_child(i)
	collider.queue_free()