extends "res://Actors/abstract_gravity_body.gd"

onready var tween = get_node("Tween")
onready var original_scale = get_scale()
export (float) var pulse_interval = 2.0
onready var moon = get_parent().find_node("Moon")
var can_pulse = true
func _ready():
	if acheesements.dict["void"].accomplished >= acheesements.dict["void"].total:
		get_node("Drum").play(bgm.get_pos())
	if get_parent().has_method("set_game_state"):
		get_parent().set_game_state(1)
	if moon != null:
		_move_away(moon, self)
		if moon.get_node("Gravity/Sprite").get_opacity() <= 0.0:
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
		var direction = (from.get_pos() - to.get_pos()).normalized()
		var spawn_offset = get_pos() + Vector2(100, 100) * direction
		tween.interpolate_property(self, "transform/pos", get_pos(),
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

