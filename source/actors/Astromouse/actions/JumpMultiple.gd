extends "res://actors/Astromouse/actions/Jump.gd"

export (int) var total = 2
var available = total

func apply(kinematic_actor):
	if available > 0:
		available -= 1
		.apply(kinematic_actor)

func reset():
	available = total
