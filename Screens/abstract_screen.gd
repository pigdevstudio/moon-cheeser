extends Control

var s = load("res://Screens/Title_Screen/TitleScreen.tscn")

func _ready():
	set_aspect()

func change_to_next_scene(scene = s):
	if typeof(scene) == TYPE_STRING:
		get_tree().change_scene(scene)
	else:
		get_tree().change_scene(scene.get_path())

func set_aspect():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED, SceneTree.STRETCH_ASPECT_IGNORE, Vector2())
