extends RigidBody2D
export (float) var jump_force = 300
var can_jump = true setget _body_enter

func jump():
	if can_jump:
		apply_impulse(Vector2(0,0), Vector2(0, -1) * jump_force)
		can_jump = false

func _body_enter( body ):
	var g = body.get_groups()
	if "moon" in g:
		can_jump = true
	elif "enemy" in g:
		get_tree().change_scene("res://Screens/Score_Screen/ScoreScreen.tscn")
	elif "cheese" in g:
		print("scored +1")