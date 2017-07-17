extends StaticBody2D

var player = null setget _body_enter
var is_mouse_on = false setget _mouse_enter
var already_pressed = false
var gravity_strength = 200
onready var s = get_node("Surface")
onready var fixed_process = set_fixed_process(true)

func _fixed_process(delta):
	get_node("Sprite").rotate( deg2rad(45) * delta)
	if Input.is_action_pressed("jump") and is_mouse_on and not already_pressed:
		if not player == null:
			if get_parent().game_state == 0:
				player.jump()
			elif get_parent().game_state ==1:
				var n = Vector2(0, -gravity_strength).rotated(s.get_angle_to(player.get_pos()))
				player.apply_impulse(player.get_pos(), n)
				
	already_pressed = Input.is_action_pressed("jump")
	
func _body_enter( body ):
	if body.is_in_group("player"):
		player = body
	elif body.is_in_group("cheese"):
		body.queue_free()

func _mouse_enter(value):
	is_mouse_on = value