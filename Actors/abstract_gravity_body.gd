extends Node2D

export (float) var gravity_strength = 200
const MAX_GRAVITY = 600

func _apply_gravity(target):
	if target != null:
		get_tree().get_nodes_in_group("player")[0].set_gravity_scale(1)
		var direction = (get_pos() - target.get_pos()).normalized()
		target.apply_impulse(Vector2(0, 0), gravity_strength * direction)
		if is_in_group("moon"):
			target.set_angular_velocity(-target.get_angle_to(get_pos()))
		else:
			target.set_angular_velocity(target.get_angle_to(get_pos()))
func _find_player():
	var player = null
	if get_tree().get_nodes_in_group("player").size() > 0:
		player = get_tree().get_nodes_in_group("player")[0]
		if player extends RigidBody2D:
			return(player)
		else:
			return(null)