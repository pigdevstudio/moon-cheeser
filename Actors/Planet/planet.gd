extends "res://Actors/abstract_gravity_body.gd"

onready var tween = get_node("Tween")
onready var original_scale = get_scale()
export (float) var pulse_interval = 2.0
func _ready():
	if get_parent().has_method("set_game_state"):
		get_parent().set_game_state(1)
	var moon = get_parent().find_node("Moon")
	if moon != null:
		_move_away(moon, self)
		yield(tween, "tween_complete")
	pulse()

func pulse():
	if get_scale() <= original_scale:
		tween.interpolate_property(self, "transform/scale", get_scale(), get_scale() * 1.07,
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
	if from != null and to != null:
		var direction = (from.get_pos() - to.get_pos()).normalized()
		var spawn_offset = get_pos() + Vector2(100, 100) * direction
		tween.interpolate_property(self, "transform/pos", get_pos(),
		spawn_offset, 3.0, tween.TRANS_BACK, tween. EASE_OUT)
	tween.start()
	yield(tween, "tween_complete")

func _on_life_spam():
	var moon = get_parent().find_node("Moon")
	_move_away(self, moon)
	yield(tween, "tween_complete")
	if get_parent().has_method("set_game_state"):
		get_parent().set_game_state(0)
		pass
	queue_free()
	
func _increase_gravity():
	if gravity_strength <= MAX_GRAVITY:
		gravity_strength *= 1.2

