extends Node

signal game_over

const Starmouse = preload("res://actors/starmouse/StarMouse.gd")
const SpaceActor = preload("res://actors/Astromouse/SpaceActor.gd")

var astromouse = null setget _set_astromouse

func _ready():
	self.astromouse = $Astromouse
	randomize()

func _set_astromouse(new_astromouse):
	if not new_astromouse:
		return
	astromouse = new_astromouse
	astromouse.connect("died", self, "_on_Astromouse_died")
	$Moon.astromouse = astromouse

func _on_Astromouse_died():
 	emit_signal("game_over")

func _on_Starmouse_tree_exiting(starmouse):
	instance_astromouse(starmouse.position)

func instance_astromouse(spawn_position):
	var spawner = $AstromouseSpawner
	spawner.position = spawn_position
	spawner.spawn()

func add_child(node, legible_unique_name = false):
	if node is Starmouse:
		astromouse.queue_free()
		node.connect("tree_exiting", self, "_on_Starmouse_tree_exiting", [node])
	elif node is SpaceActor:
		_set_astromouse(node)
	return .add_child(node, legible_unique_name)
