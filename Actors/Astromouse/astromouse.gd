extends RigidBody2D

signal died
export (float) var jump_force = 300
var can_jump = true

onready var default_gravity_scale = get_gravity_scale()

func _ready():
	set_fixed_process(true)
	connect("died", get_parent().get_parent(), "change_to_next_scene", ["res://Screens/Score_Screen/ScoreScreen.tscn"])
		
func _fixed_process(delta):
	if get_linear_velocity().y > 0 and not can_jump:
		get_child(0).play("jumping")

func jump():
	if can_jump:
		var direction = Vector2(0, -1)
		apply_impulse(Vector2(0,0), jump_force * direction)
		get_child(0).play("jumping")
		get_child(0).stop()
	can_jump = false

func _body_enter( body ):
	if body.is_in_group("moon"):
		rotate(get_angle_to(body.get_pos()))
		get_child(0).play("running")
		can_jump = true
		
	elif body.is_in_group("enemy"):
		if body.is_in_group("void"):
			acheesements.modify_achievement("void", 1)
		emit_signal("died")
		
	elif body.is_in_group("cheese"):
		body.increase_score()