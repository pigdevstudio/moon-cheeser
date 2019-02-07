#MIT License
#
#Copyright (c) 2017 Pigdev Studio
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.
extends "res://actors/abstract_gravity_body.gd"

var is_mouse_on = false
var is_field_on = false
var already_pressed = false
onready var gravity = get_node("Gravity/Sprite")
onready var fixed_process = set_physics_process(true)

func _ready():
	scale = gravity.get_scale()

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
		t.interpolate_property(gravity, "scale", scale, scale * 1.2, 0.5, t.TRANS_BACK, t.EASE_OUT)
		t.start()
		yield(t, "tween_complete")
		t.interpolate_property(gravity, "scale", gravity.get_scale(), scale, 0.5, t.TRANS_BACK, t.EASE_OUT)
		t.start()
		yield(t, "tween_completed")
		t.set_active(false)
		
func show_gravity():
	var t = get_node("Tween")
	if is_field_on == false and not t.is_active():
		is_field_on = true
		var initial_color = modulate
		var transparent = modulate
		transparent.a = 0.0
		t.interpolate_property(gravity, "modulate", transparent, initial_color, 1.0, t.TRANS_EXPO, t.EASE_OUT)
		t.start()
		yield(t, "tween_completed")
		t.set_active(false)
	
func hide_gravity():
	var t = get_node("Tween")
	if is_field_on == true and not t.is_active():
		is_field_on = false
		var initial_color = modulate
		var transparent = modulate
		transparent.a = 0.0
		t.interpolate_property(gravity, "modulate", initial_color, transparent, 1.0, t.TRANS_EXPO, t.EASE_OUT)
		t.start()
		yield(t, "tween_completed")
		t.set_active(false)
