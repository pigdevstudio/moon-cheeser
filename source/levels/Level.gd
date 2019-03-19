extends Node

signal game_over

const Starmouse = preload("res://actors/starmouse/StarMouse.gd")
const Astromouse = preload("res://actors/astromouse/Astromouse.gd")
const Blackhole = preload("res://objects/gravity_bodies/blackhole/Blackhole.gd")

var astromouse = null setget set_astromouse

func _ready():
	set_astromouse($Astromouse)
	get_tree().connect("node_added", self, "_on_SceneTree_node_added")
	randomize()

func set_astromouse(new_astromouse):
	astromouse = new_astromouse
	astromouse.become_invincible()
	astromouse.connect("died", self, "_on_Astromouse_died")
	$Moon.astromouse = astromouse
	if has_node("Blackhole"):
		get_node("Blackhole").astromouse = astromouse

func _on_Astromouse_died():
 	emit_signal("game_over")

func _on_Starmouse_tree_entered(starmouse):
	astromouse.queue_free()
	starmouse.connect("tree_exiting", self, "_on_Starmouse_tree_exiting", [starmouse])

func _on_Starmouse_tree_exiting(starmouse):
	instance_astromouse(starmouse.position)

func _on_SceneTree_node_added(node):
	treat_new_node(node)

func _on_Blackhole_tree_entered(blackhole):
	blackhole.connect("tree_exited", self, "_on_Blackhole_tree_exited")
	blackhole.astromouse = astromouse
	$Moon.set_physics_process(false)
	$Moon.set_process_unhandled_input(true)
	get_tree().call_group("flyingbody_spawner", "stop")
	get_tree().call_group("flying_body", "queue_free")
	get_tree().call_group("crater", "queue_free")

func _on_Blackhole_tree_exited():
	if is_inside_tree():
		get_tree().call_group("flyingbody_spawner", "reset_timer")
		$Moon.set_physics_process(true)
		$Moon.set_process_unhandled_input(false)

func instance_astromouse(spawn_position):
	var spawner = $AstromouseSpawner
	spawner.position = spawn_position
	spawner.spawn()

func treat_new_node(node):
	if node is Starmouse:
		_on_Starmouse_tree_entered(node)
	elif node.has_node("Actions"):
		set_astromouse(node)
	elif node is Blackhole:
		_on_Blackhole_tree_entered(node)
