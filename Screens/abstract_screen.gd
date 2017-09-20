extends Control

var s = load("res://Screens/Title_Screen/TitleScreen.tscn")

func _ready():
	set_aspect()

func change_to_next_scene(scene = s):
	transition.get_node("Animator").play_backwards("fade")
	if typeof(scene) == TYPE_STRING:
		get_tree().change_scene(scene)
	else:
		get_tree().change_scene(scene.get_path())

func set_aspect():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_KEEP, Vector2(1280,720))
