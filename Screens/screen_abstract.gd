extends Control

var s = load("res://Screens/Title_Screen/TitleScreen.tscn")

func change_to_next_scene(scene = s):
	if typeof(scene) == TYPE_STRING:
		get_tree().change_scene(scene)
	else:
		get_tree().change_scene(scene.get_path())
