extends "res://Actors/abstract_gravity_body.gd"

var is_mouse_on = false
var is_field_on = false
var already_pressed = false
onready var gravity = get_node("Gravity/Sprite")
onready var scale = gravity.get_scale()
onready var fixed_process = set_fixed_process(true)

func _fixed_process(delta):
	get_node("Sprite").rotate( deg2rad(90) * delta)
	_astromouse_interact()

func _astromouse_interact():
	if OS.get_name() == "Android":
		if Input.is_mouse_button_pressed(BUTTON_LEFT) and is_mouse_on and not already_pressed:
			var player = _find_player()
			if player != null and player.has_method("jump"):
				if get_parent().get_game_state() == 0:
					player.jump()
				elif get_parent().get_game_state() == 1:
					_apply_gravity(player)
					_pulse()
		elif not Input.is_mouse_button_pressed(BUTTON_LEFT) and is_mouse_on and already_pressed:
			var player = _find_player()
			if player != null and not player.is_falling():
				player.set_linear_velocity(Vector2(0, 0))
		already_pressed = Input.is_mouse_button_pressed(BUTTON_LEFT)
		
	else:
		if Input.is_action_pressed("jump") and not already_pressed:
			var player = _find_player()
			if player != null and player.has_method("jump"):
				if get_parent().get_game_state() == 0:
					player.jump()
				elif get_parent().get_game_state() == 1:
					_apply_gravity(player)
					_pulse()
					
		elif not Input.is_action_pressed("jump") and already_pressed:
			var player = _find_player()
			if player != null and not player.is_falling():
				player.set_linear_velocity(Vector2(0, 0))
		already_pressed = Input.is_action_pressed("jump")

func _mouse_enter(value):
	is_mouse_on = value

func _pulse():
	var t = get_node("Tween")
	show_gravity()
	if not t.is_active() and get_parent().get_game_state() == 1:
		t.interpolate_property(gravity, "transform/scale", scale, scale * 1.2, 0.5, t.TRANS_BACK, t.EASE_OUT)
		t.start()
		yield(t, "tween_complete")
		t.interpolate_property(gravity, "transform/scale", gravity.get_scale(), scale, 0.5, t.TRANS_BACK, t.EASE_OUT)
		t.start()
		yield(t, "tween_complete")
		t.set_active(false)
		
func show_gravity():
	var t = get_node("Tween")
	if is_field_on == false and not t.is_active():
		is_field_on = true
		t.interpolate_property(gravity, "visibility/opacity", 0.0, 1.0, 1.0, t.TRANS_EXPO, t.EASE_OUT)
		t.start()
		yield(t, "tween_complete")
		t.set_active(false)
	
func hide_gravity():
	var t = get_node("Tween")
	if is_field_on == true and not t.is_active():
		is_field_on = false
		t.interpolate_property(gravity, "visibility/opacity", 1.0, 0.0, 1.0, t.TRANS_EXPO, t.EASE_OUT)
		t.start()
		yield(t, "tween_complete")
		t.set_active(false)