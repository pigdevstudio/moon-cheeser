extends StaticBody2D

onready var t = get_node("Tween")
onready var moon = get_parent().find_node("Moon")
onready var player
onready var s = get_node("Sprite")
onready var scale = s.get_scale()

var gravity_strength = 200
var max_gravity = 800
func _ready():
	get_parent().game_state = 1
	if moon != null:
		var n = (moon.get_pos() - get_pos()).normalized()
		t.interpolate_property(self, "transform/pos", get_pos(),
		get_pos() + Vector2(100, 100) * n, 3.0, t.TRANS_BACK, t.EASE_OUT)
		t.start() 
		yield(t, "tween_complete")
		_scale_up()
func _scale_up():
	player = get_parent().find_node("Astromouse")
	t.interpolate_property(s, "transform/scale", scale, scale * 1.07, 1.0, t.TRANS_BACK, t.EASE_OUT)
	t.start()
	player.set_gravity_scale(2)
	var g = min(gravity_strength, max_gravity)
	var n =  Vector2(0, -g).rotated(get_angle_to(player.get_pos()))
	player.apply_impulse(player.get_pos(), n)
	gravity_strength *= 1.3
	if get_node("LifeSpam").is_active():
		yield(t, "tween_complete")
		_scale_down()

func _scale_down():
	t.interpolate_property(s, "transform/scale", s.get_scale(), scale, 1.0, t.TRANS_BACK, t.EASE_IN)
	t.start()
	if get_node("LifeSpam").is_active():
		yield(t, "tween_complete")
		_scale_up()

func _on_LifeSpam():
	player.set_gravity_scale(8)
	player.can_jump = false
	get_parent().game_state = 0
	var n = (get_pos() -moon.get_pos()).normalized()
	t.interpolate_property(self, "transform/pos", get_pos(),
	get_pos() + Vector2(300, 300) * n, 3.0, t.TRANS_BACK, t.EASE_OUT)
	t.start()
	if get_node("LifeSpam").is_active():
		yield(t, "tween_complete")
		queue_free()