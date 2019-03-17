extends "res://actors/astromouse/actions/Jump.gd"

export (int) var total = 2
var available = total

func apply(space_space_kinematic_body):
	if available > 0:
		available -= 1
		.apply(space_space_kinematic_body)

func reset():
	available = total
