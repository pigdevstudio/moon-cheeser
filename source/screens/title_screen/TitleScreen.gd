extends Control

export(String, FILE, "*.tscn") var game_scene
export(String, FILE, "*.tscn") var achievements_scene
export(String, FILE, "*.tscn") var skins_scene

onready var _fade_rect = $FadeRect


func change_scene(next_scene_path):
	yield(_fade_rect.fade_out(), "completed")
	get_tree().change_scene(next_scene_path)


func _on_PlayButton_pressed():
	change_scene(game_scene)


func _on_AchievementsButton_pressed():
	change_scene(achievements_scene)


func _on_SkinsButton_pressed():
	change_scene(skins_scene)
