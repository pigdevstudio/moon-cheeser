extends RigidBody2D
export (float) var jump_force = 300
var can_jump = true

func jump():
	if can_jump:
		var direction = Vector2(0, -1)
		apply_impulse(Vector2(0,0), jump_force * direction)
	can_jump = false

func _body_enter( body ):
	if body.is_in_group("moon"):
		can_jump = true
		
	elif body.is_in_group("enemy"):
		get_tree().change_scene("res://Screens/Score_Screen/ScoreScreen.tscn")
		
	elif body.is_in_group("cheese"):
		body.queue_free()
		
func battle_gravity(object, gravity):
	set_gravity_scale(1)
	var direction = (object.get_global_pos() - get_global_pos()).normalized()
	apply_impulse(get_pos(), gravity * direction)
	
func finish_gravity():
	set_gravity_scale(12)