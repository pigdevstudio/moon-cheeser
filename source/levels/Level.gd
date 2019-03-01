extends Node

const Starmouse = preload("res://actors/starmouse/StarMouse.gd")

func _ready():
	$Moon.astromouse = $Astromouse
	randomize()


func instance_astromouse(spawn_position):
	var spawner = $AstromouseSpawner
	
	spawner.position = spawn_position
	$Moon.astromouse = spawner.spawn()


func add_child(node, legible_unique_name = false):
	if node is Starmouse:
		node.connect("tree_exiting", self, "_on_Starmouse_tree_exiting", [node])
	return .add_child(node, legible_unique_name)


func _on_Starmouse_tree_exiting(starmouse):
	instance_astromouse(starmouse.position)
