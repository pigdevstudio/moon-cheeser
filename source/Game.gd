extends Node

"""
Controls game's flow
"""

export(String, FILE, "*.tscn") var score_scene_path
export(String, FILE, "*.tscn") var main_scene_path

onready var _fade = $InterfaceLayer/FadeRect

var _level
var _current_level_path


func _ready():
	setup_level()


func setup_level():
	_level = load(PlayerData.current_level_path).instance()
	add_child(_level)
	_level.connect("astromouse_died", self, "_on_Level_astromouse_died")
	_level.connect("finished", self, "_on_Level_finished")


func change_scene(next_scene_path):
	yield(_fade.fade_out(), "completed")
	get_tree().change_scene(next_scene_path)


func load_next_level():
	PlayerData.current_level_path = _level.next_level_path
	_level.queue_free()
	setup_level()


func _on_Level_astromouse_died():
	yield(_fade.fade_out(), "completed")
	get_tree().change_scene(score_scene_path)


func _on_Level_finished():
	load_next_level()


func _on_BackButton_pressed():
	_fade.change_scene(main_scene_path)
