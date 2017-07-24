extends StaticBody2D

export (float) var gravity_strength = 200
export (float) var pulse_interval = 2.0
const MAX_GRAVITY = 600
onready var tween = get_node("Tween")
onready var original_scale = get_scale()

func _apply_gravity(target):
	if target != null:
		var direction = (get_pos() - target.get_pos()).normalized()
		target.set_gravity_scale(1) #move it to the game state controller
		target.apply_impulse(Vector2(0, 0), gravity_strength * direction)

func _find_player():
	var player
	if get_tree().get_nodes_in_group("player").size() > 0:
		player = get_tree().get_nodes_in_group("player")[0]
		return(player)