extends StaticBody2D

var player = null
var already_pressed = false
onready var fixed_process = set_fixed_process(true)

func body_enter( body ):
	if body.is_in_group("player") and body.has_method("jump"):
		player = body
		player.can_jump = true

func _fixed_process(delta):
	if not player == null:
		if Input.is_action_pressed("jump") and not already_pressed and player.can_jump:
			player.initial_pos = player.get_pos()
			player.can_jump = false
		
		if Input.is_action_pressed("jump"):
			player.is_jumping = true
		
		elif not Input.is_action_pressed("jump"):
			player.is_jumping = false
	already_pressed = Input.is_action_pressed("jump")