extends Node

"""
Controls game's flow
"""

export(String, FILE, "*.tscn") var score_scene_path

onready var _level = $Level
onready var _fade = $InterfaceLayer/FadeRect


func _ready():
	setup_level()


func setup_level():
	_level.connect("astromouse_died", self, "_on_Level_astromouse_died")
	_level.connect("finished", self, "_on_Level_finished")


func change_scene(next_scene_path):
	yield(_fade.fade_out(), "completed")
	get_tree().change_scene(next_scene_path)


func load_next_level():
	var next_level = load(_level.next_level_path).instance()
	_level.queue_free()
	add_child(next_level)
	_level = next_level
	setup_level()


func _on_Level_astromouse_died():
	change_scene(score_scene_path)


func _on_Level_finished():
	load_next_level()
