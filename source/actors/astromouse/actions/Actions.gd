extends Node

var actor setget set_actor


func set_actor(new_actor):
	actor = new_actor
	for action in get_children():
		action.actor = actor
