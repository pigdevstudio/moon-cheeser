extends Node2D

signal finished(dummy)
signal event_horizon_entered

const MAX_PUSH = 0.7

export var pull_strength = 0.1
export var gravity_strength = 1000.0
export var event_horizon_radius = 64.0

onready var _sprite = $Sprite
onready var _tween = $Tween
onready var dummy = $Astromouse


func _ready():
	set_physics_process(false)
	dummy.get_node("Character").swap_skin()
	dummy.get_node("Character").play("run_fall")


func _physics_process(delta):
	var velocity = global_position.direction_to(dummy.global_position) * gravity_strength
	velocity *= -pull_strength
	dummy.move_and_collide(velocity * delta)
	if dummy.global_position.distance_to(global_position) < event_horizon_radius:
		emit_signal("event_horizon_entered")


func pulse():
	var initial_scale = Vector2.ONE
	var final_scale = initial_scale * 1.3
	_tween.interpolate_property(_sprite, "scale", initial_scale,
			final_scale, 1.0, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")
	_tween.interpolate_property(_sprite, "scale", final_scale,
			initial_scale, 1.0, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	_tween.start()


func _on_Duration_timeout():
	emit_signal("finished", dummy)
	queue_free()
