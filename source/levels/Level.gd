extends Node

signal game_over

var astromouse setget set_astromouse
var has_astromouse = false

func _ready():
	set_astromouse($Astromouse)
	get_tree().connect("node_added", self, "_on_SceneTree_node_added")
	randomize()

func set_astromouse(new_astromouse):
	astromouse = new_astromouse
	astromouse.become_invincible()
	astromouse.connect("died", self, "_on_Astromouse_died")
	astromouse.connect("tree_exited", self, "_on_Astromouse_tree_exited")
	has_astromouse = true

func _on_Astromouse_tree_entered(new_astromouse):
	set_astromouse(new_astromouse)
	$Moon.astromouse = astromouse

func _on_Astromouse_tree_exited():
	has_astromouse = false

func _on_Astromouse_died():
 	emit_signal("game_over")

func _on_Starmouse_tree_entered(starmouse):
	if Achievements.is_achievement_complete("starmouse"):
		$Background.show_crux()
		BGM.play_track("Harmony")
	astromouse.queue_free()
	starmouse.connect("tree_exiting", self, "_on_Starmouse_tree_exiting", [starmouse])

func _on_Starmouse_tree_exiting(starmouse):
	if Achievements.is_achievement_complete("starmouse"):
		$Background.hide_crux()
		BGM.stop_track("Harmony")
	instance_astromouse(starmouse.position)

func _on_SceneTree_node_added(node):
	treat_new_node(node)

func _on_Blackhole_tree_entered(blackhole):
	if Achievements.is_achievement_complete("gravity"):
		BGM.play_track("Pad")
	blackhole.connect("tree_exited", self, "_on_Blackhole_tree_exited")
	if has_astromouse:
		blackhole.astromouse = astromouse
		var astromouse_actions = astromouse.get_action_node()
		astromouse_actions.set_process_unhandled_input(false)
	$Moon.set_physics_process(false)
	$Moon.set_process_unhandled_input(true)
	get_tree().call_group("flyingbody_spawner", "stop")
	get_tree().call_group("flying_body", "queue_free")
	get_tree().call_group("crater", "queue_free")

func _on_Blackhole_tree_exited():
	if is_inside_tree():
		if Achievements.is_achievement_complete("gravity"):
			BGM.stop_track("Pad")
		get_tree().call_group("flyingbody_spawner", "reset_timer")
		$Moon.set_physics_process(true)
		$Moon.set_process_unhandled_input(false)
		if has_astromouse:
			var astromouse_actions = astromouse.get_action_node()
			astromouse_actions.set_process_unhandled_input(true)

func instance_astromouse(spawn_position):
	var spawner = $AstromouseSpawner
	spawner.position = spawn_position
	spawner.spawn()

func treat_new_node(node):
	if node.has_node("SteeringSeek") and node.has_node("PickupArea"):
		_on_Starmouse_tree_entered(node)
	elif node.has_node("Actions"):
		_on_Astromouse_tree_entered(node)
	elif node.has_node("Gravity") and node.has_node("KillingArea"):
		_on_Blackhole_tree_entered(node)
