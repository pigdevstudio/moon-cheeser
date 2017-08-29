extends Node

export (int, "NORMAL", "GRAVITATIONAL_BATTLE") var game_state setget set_game_state, get_game_state

func _ready():
	connect("exit_tree", acheesements, "write_achievements")
	
func set_game_state(state):
	if is_inside_tree():
		if state == 0:
			get_tree().get_nodes_in_group("player")[0].set_gravity_scale(12)
		elif state == 1:
			get_tree().call_group(SceneTree.GROUP_CALL_DEFAULT, "crater", "queue_free")
			pass
	game_state = state

func get_game_state():
	return(game_state)