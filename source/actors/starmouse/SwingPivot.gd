extends Position2D

"""
Swing following a movement direction to give an inertia aspect
"""

export (float) var movement_threshold = 800.0
export (float, 1.0) var dampling = 0.02

func swing(movement_velocity):
	var movement_angle_degrees = rad2deg(movement_velocity.angle())
	
	var angle_offset_degrees = 90
	var target_angle_degrees = movement_angle_degrees + angle_offset_degrees
	rotation_degrees = target_angle_degrees
	flip_horizontally()

func damp_to_rest_angle():
	var rest_angle_degrees = get_rest_angle_degrees()
	rotation_degrees = lerp(rotation_degrees, rest_angle_degrees, dampling)

func flip_horizontally():
	var min_angle_degrees = -50
	var max_angle_degrees = 150
	
	var flip = rotation_degrees >= -min_angle_degrees
	flip = flip and rotation_degrees <= max_angle_degrees
	if flip:
		scale.x = 1
	else:
		scale.x = -1

func get_rest_angle_degrees():
	var target_angle = 360.0
	if rotation_degrees > -180 and rotation_degrees <= 180:
		target_angle = 0.0
	return target_angle
