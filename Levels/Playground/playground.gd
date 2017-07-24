extends Node2D

export (int, "NORMAL", "GRAVITATIONAL_BATTLE") var game_state setget set_game_state, get_game_state
func _ready():
#	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_IGNORE, Vector2(1280,720))
	pass
	
func set_game_state(state):
	if is_inside_tree():
		if state == 0:
			get_tree().get_nodes_in_group("player")[0].set_gravity_scale(12)
		elif state == 1:
#			var star_mouse = get_tree().get_nodes_in_group("starmouse")[0]._on_timeout()
			get_node("Moon").prepare_for_gravity()
	game_state = state
		
func get_game_state():
	return(game_state)