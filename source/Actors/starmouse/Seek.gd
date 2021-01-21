extends Node2D

export (float) var mass = 20.0

func steer(current_velocity, desired_velocity):
	var steering =  desired_velocity - current_velocity
	steering /= mass
	
	return steering
