extends "res://Actors/abstract_gravity_body.gd"

var is_mouse_on = false
var already_pressed = false
onready var fixed_process = set_fixed_process(true)
var is_dragging = false
func _fixed_process(delta):
	get_node("Sprite").rotate( deg2rad(90) * delta)
	_astromouse_interact()

func _astromouse_interact():
	if not OS.get_name() == "Android":
		if Input.is_mouse_button_pressed(BUTTON_LEFT) and is_mouse_on and not already_pressed:
			var player = _find_player()
			if player != null and player.has_method("jump"):
				if get_parent().get_game_state() == 0:
					player.jump()
				elif get_parent().get_game_state() == 1:
					_apply_gravity(player)
		already_pressed = Input.is_mouse_button_pressed(BUTTON_LEFT)
		
	else:
		if Input.is_action_pressed("jump") and not already_pressed:
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
	if not is_dragging:
		is_mouse_on = value
	