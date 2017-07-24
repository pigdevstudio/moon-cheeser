extends "res://Actors/abstract_gravity_body.gd"

var is_mouse_on = false setget _mouse_enter
var already_pressed = false

export (float, 5.0, 0.5) var speed_multiplier
onready var fixed_process = set_fixed_process(true)

func _fixed_process(delta):
	get_node("Sprite").rotate( deg2rad(45) * delta * speed_multiplier)
	_astromouse_interact()

func _astromouse_interact():
	if Input.is_action_pressed("jump") and is_mouse_on and not already_pressed:
		var player = _find_player()
		if player != null and player.has_method("jump"):
			if get_parent().get_game_state() == 0:
				player.jump()
			elif get_parent().get_game_state() == 1:
				_apply_gravity(player)
	already_pressed = Input.is_action_pressed("jump")

func _body_enter( body ):
	if body.is_in_group("player"):
		pass

func _mouse_enter(value):
	is_mouse_on = value
	
func prepare_for_gravity():
	for c in get_node("Sprite").get_children():
		if c.is_in_group("enemy"):
			c.queue_free()