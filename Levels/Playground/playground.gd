extends Node2D

export (int, "NORMAL", "GRAVITATIONAL_BATTLE") var game_state setget set_game_state
func _ready():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_IGNORE, Vector2(1280,720))
	
func set_game_state(state):
	game_state = state
	if is_inside_tree():
		if state == 0:
			get_node("Astromouse").can_jump = true
		elif state == 1:
			if get_node("Astromouse") != null:
				get_node("Astromouse").can_jump = false