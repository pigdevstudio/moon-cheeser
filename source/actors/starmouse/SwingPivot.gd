extends Position2D

"""
Swing following a movement direction to give an inertia aspect
"""

export (float) var angle_offset_degrees = 90
export (float, 1.0) var dampling = 0.02

var movement_velocity = Vector2(0, 0)
var is_swinging = false

func swing():
	is_swinging = true
	var movement_angle_degrees = rad2deg(movement_velocity.angle())
	
	var target_angle_degrees = movement_angle_degrees + angle_offset_degrees
	rotation_degrees = target_angle_degrees
	flip_horizontally()

func rest():
	is_swinging = false
	damp_to_rest_angle()

func damp_to_rest_angle():
	var rest_angle_degrees = get_rest_angle_degrees()
	while not is_swinging:
		rotation_degrees = lerp(rotation_degrees, rest_angle_degrees, dampling)
		yield(get_tree(), "physics_frame")

func flip_horizontally():
	var is_flipped = movement_velocity.x < 0
	if is_flipped:
		scale.x = -1
	else:
		scale.x = 1

func get_rest_angle_degrees():
	var rest_angle = 0.0
	
	var quadrant = get_angle_quadrant()
	if quadrant == 2 or quadrant == 4:
		rest_angle = 360.0
	
	return rest_angle

func get_angle_quadrant():
	var angle_quadrant = 1
	
	var angle = rotation_degrees - angle_offset_degrees
	
	angle_quadrant = int(ceil(angle / 90))
	return angle_quadrant
