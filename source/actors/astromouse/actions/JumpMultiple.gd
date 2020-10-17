extends "res://actors/astromouse/actions/Jump.gd"

export (int) var total = 2
var available = total

func execute():
	if actor.velocity.length() > 0.0:
		return
	if available > 0:
		available -= 1
		.apply(actor)


func reset():
	available = total


func _unhandled_input(event):
	if Globals.dragging:
		return
	
	if event.is_action("click"):
		if event.is_pressed():
			var jump_velocity = Vector2.UP.rotated(actor.rotation) * 500
			actor.velocity = jump_velocity
