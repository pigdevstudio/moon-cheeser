extends Node

"""
Controls game's flow
"""

export(String, FILE, "*.tscn") var score_scene_path

onready var _level = $Level
onready var _fade = $InterfaceLayer/FadeRect

func setup_level():
	_level.connect("astromouse_died", self, "")


func _on_Level_astromouse_died():
	change_scene(score_scene_path)


func change_scene(next_scene_path):
	yield(_fade.fade_out(), "completed")
	get_tree().change_scene(next_scene_path)
