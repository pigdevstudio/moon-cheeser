extends StaticBody2D

var player = null setget _body_enter
var is_mouse_on = false setget _mouse_enter
var already_pressed = false

onready var fixed_process = set_fixed_process(true)

func _fixed_process(delta):
	if Input.is_action_pressed("jump") and is_mouse_on and not already_pressed:
		if not player == null:
			player.jump()
	already_pressed = Input.is_action_pressed("jump")
	
func _body_enter( body ):
	if body.is_in_group("player"):
		player = body

func _mouse_enter(value):
	is_mouse_on = value