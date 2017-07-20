extends Node2D

export (int, "NORMAL", "GRAVITATIONAL_BATTLE") var game_state setget set_game_state, get_game_state
func _ready():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_IGNORE, Vector2(1280,720))
	
func set_game_state(state):
	game_state = state
	if state == 1:
		get_node("Moon").prepare_for_gravity()
		
func get_game_state():
	return(game_state)