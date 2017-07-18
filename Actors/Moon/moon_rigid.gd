extends StaticBody2D

var player = null
var is_mouse_on = false setget _mouse_enter
var already_pressed = false
var gravity_strength = 200
onready var s = get_node("Surface")
onready var fixed_process = set_fixed_process(true)

func _fixed_process(delta):
	get_node("Sprite").rotate( deg2rad(45) * delta)
	if Input.is_action_pressed("jump") and is_mouse_on and not already_pressed:
		player = _find_player()
		if not player == null:
			if get_parent().game_state == 0:
				player.jump()
			elif get_parent().game_state ==1:
				player.battle_gravity(self, gravity_strength)
				
	already_pressed = Input.is_action_pressed("jump")
	
func _body_enter( body ):
	if body.is_in_group("player"):
		player = body
	elif body.is_in_group("cheese"):
		body.queue_free()

func _mouse_enter(value):
	is_mouse_on = value

func _find_player():
	for c in get_parent().get_children():
		if c.is_in_group("player"):
			return(c)
