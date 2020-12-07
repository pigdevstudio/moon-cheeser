extends Control


export(String, FILE, "*.tscn") var title_scene_path

onready var _fade = $FadeRect


func _on_BackButton_pressed():
	yield(_fade.fade_out(), "completed")
	get_tree().change_scene(title_scene_path)
