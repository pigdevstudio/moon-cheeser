extends Position2D

"""
Swing following a movement direction to give an inertia aspect
"""

export (float) var angle_offset_degrees = 90.0
export (float, 1.0) var damping = 0.02

var movement_velocity = Vector2(0, 0)
var is_swinging = false

onready var _tween = $Tween

func swing():
	if _tween.is_active():
		_tween.stop_all()
	is_swinging = true
	var movement_angle_degrees = rad2deg(movement_velocity.angle())
	
	var target_angle_degrees = movement_angle_degrees + angle_offset_degrees
	rotation_degrees = target_angle_degrees
	flip_horizontally()


func rest():
	is_swinging = false
	damp_to_rest_angle()


func damp_to_rest_angle():
	_tween.stop_all()
	var rest_angle_degrees = get_rest_angle_degrees()
#	while not is_swinging:
#		rotation_degrees = lerp(rotation_degrees, rest_angle_degrees, damping)
#		yield(get_tree(), "physics_frame")
	_tween.interpolate_property(self, "rotation_degrees", rotation_degrees,
			rest_angle_degrees, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	_tween.start()


func flip_horizontally():
	var is_flipped = movement_velocity.x < 0
	if is_flipped:
		scale.x = -1
	else:
		scale.x = 1


func get_rest_angle_degrees():
	var is_movement_bottom_left = movement_velocity.y > 0 and movement_velocity.x < 0 
	
	var rest_angle = 0.0 if not is_movement_bottom_left else 360.0
	return rest_angle
	
