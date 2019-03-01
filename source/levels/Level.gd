extends Node

const Starmouse = preload("res://actors/starmouse/StarMouse.gd")
const SpaceActor = preload("res://actors/Astromouse/SpaceActor.gd")

var astromouse = null setget set_astromouse

func _ready():
	self.astromouse = $Astromouse
	randomize()

func _on_Starmouse_tree_exiting(starmouse):
	instance_astromouse(starmouse.position)

func instance_astromouse(spawn_position):
	var spawner = $AstromouseSpawner
	spawner.position = spawn_position
	spawner.spawn()

func add_child(node, legible_unique_name = false):
	if node is Starmouse:
		node.connect("tree_exiting", self, "_on_Starmouse_tree_exiting", [node])
	elif node is SpaceActor:
		set_astromouse(node)
	return .add_child(node, legible_unique_name)

func set_astromouse(new_astromouse):
	astromouse = new_astromouse
	$Moon.astromouse = astromouse

