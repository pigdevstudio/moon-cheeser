extends Position2D

var movement_threshold = 0.0
var stop_dampling = 0.05

func swing(movement_direction):
	var movement_angle_degrees = rad2deg(movement_direction.angle())
	
	if movement_direction.length() <= movement_threshold:
		var target_angle = get_target_angle()
		rotation_degrees = lerp(rotation_degrees, target_angle, stop_dampling)
	else:
		var angle_offset = 90
		rotation_degrees = movement_angle_degrees + angle_offset
		flip_horizontally()

func flip_horizontally():
	if rotation_degrees > -180 and rotation_degrees <= 180:
		scale.x = 1
	else:
		scale.x = -1
		
func get_target_angle():
	var target_angle = 360.0
	if rotation_degrees > -180 and rotation_degrees <= 180:
		target_angle = 0.0
	return target_angle
