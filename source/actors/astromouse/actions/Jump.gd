extends Node

signal executed

export (float) var strength = 300.0
export (int) var max_jumps = 2

var actor

onready var _available_jumps = max_jumps


func _physics_process(delta):
	if actor.is_on_floor():
		reset()
		set_physics_process(false)


func execute():
	if _available_jumps < 1:
		return
	actor.snap_vector = Vector2.ZERO
	actor.velocity = actor.up_direction * strength
	_available_jumps -= 1
	emit_signal("executed")
	set_physics_process(true)


func reset():
	_available_jumps = max_jumps
	actor.snap_vector = (actor.up_direction * 32).rotated(deg2rad(180))


func cancel():
	if actor.velocity.rotated(actor.rotation).y < 0.0:
		return
	actor.velocity = Vector2(0, 0)
