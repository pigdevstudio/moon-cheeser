extends Node2D

export (int, "NORMAL", "GRAVITATIONAL_BATTLE") var game_state
export var p = false setget set_p
func _ready():
	p = false
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_IGNORE, Vector2(1280,720))
	
func set_p(v):
	p = v
	if not is_inside_tree():
		return
	get_tree().set_pause(p)