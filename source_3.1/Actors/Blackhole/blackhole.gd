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
extends "res://Actors/abstract_gravity_body.gd"

onready var tween = get_node("Tween")
onready var original_scale = get_scale()
export (float) var pulse_interval = 2.0
onready var moon = get_parent().find_node("Moon")
var can_pulse = true
func _ready():
	if acheesements.dict["void"].accomplished >= acheesements.dict["void"].total:
		get_node("Drum").play(bgm.get_position())
	if get_parent().has_method("set_game_state"):
		get_parent().set_game_state(1)
	if moon != null:
		_move_away(moon, self)
		if moon.get_node("Gravity/Sprite").modulate.a <= 0.0:
			moon.show_gravity()
		yield(tween, "tween_complete")
	pulse()

func pulse():
	if get_parent().get_game_state() == 1 and can_pulse:
		if get_scale() <= original_scale:
			tween.interpolate_property(self, "transform/scale", get_scale(), get_scale() * 1.5,
			pulse_interval / 2, tween.TRANS_BACK, tween.EASE_OUT)
			_apply_gravity(_find_player())
			_increase_gravity()
		elif get_scale() > original_scale:
			tween.interpolate_property(self, "transform/scale", get_scale(), original_scale,
			pulse_interval / 2, tween.TRANS_BACK, tween.EASE_OUT)
		tween.start()
		yield(tween, "tween_complete")
		pulse()

func _move_away(from, to):
	var easing = tween.EASE_OUT
	if from != null and to != null:
		if from == self:
			easing = tween.EASE_IN
		var direction = (from.get_position() - to.get_position()).normalized()
		var spawn_offset = get_position() + Vector2(100, 100) * direction
		tween.interpolate_property(self, "transform/pos", get_position(),
		spawn_offset, 3.0, tween.TRANS_BACK, easing)
		tween.start()

func _on_life_spam():
	can_pulse = false
	tween.interpolate_property(self, "transform/scale", get_scale(), original_scale,
	pulse_interval / 2, tween.TRANS_BACK, tween.EASE_OUT)
	tween.start()
	get_node("GUILayer/Warning/Animator").stop()
	get_node("GUILayer/Warning").hide()
	acheesements.modify_achievement("gravity", 1)
	_move_away(self, moon)
	var t = Timer.new()
	add_child(t)
	t.set_wait_time(3.0)
	t.start()
	yield(t, "timeout")
	moon.hide_gravity()
	if get_parent().has_method("set_game_state"):
		get_parent().set_game_state(0)
	_find_player().can_jump = true
	queue_free()
	
	
func _increase_gravity():
	if gravity_strength <= MAX_GRAVITY:
		gravity_strength *= 1.2

func _on_collision_enter( coll ):
	if coll.is_in_group("cheese"):
		coll.queue_free()


