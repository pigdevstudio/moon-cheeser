extends Control

var s = load("res://Screens/Title_Screen/TitleScreen.tscn")

func _ready():
	set_process_input(true)

func _input(event):
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		get_tree().set_pause(true)
func change_to_next_scene(scene = s):
	if typeof(scene) == TYPE_STRING:
		get_tree().change_scene(scene)
	else:
		get_tree().change_scene(scene.get_path())
