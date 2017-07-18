extends RigidBody2D
export (float) var jump_force = 300
var can_jump = true

func _ready():
	print(get_name())
func jump():
	if can_jump:
		apply_impulse(Vector2(0,0), Vector2(0, -1) * jump_force)
		can_jump = false

func _body_enter( body ):
	if body.is_in_group("moon"):
		can_jump = true
	elif body.is_in_group("enemy"):
#		get_tree().change_scene("res://Screens/Score_Screen/ScoreScreen.tscn")
		pass
	elif body.is_in_group("cheese"):
		body.queue_free()
		print("scored +1")
		
func battle_gravity(object, gravity):
	set_gravity_scale(1)
	var direction = (object.get_pos() - get_pos()).normalized()
	apply_impulse(get_pos(), gravity * direction)