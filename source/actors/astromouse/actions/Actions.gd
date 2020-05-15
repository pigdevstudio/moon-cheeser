extends Node

var space_kinematic_body

func _unhandled_input(event):
	if Globals.dragging:
		return
	
	if event.is_action("click"):
		if event.is_pressed():
			if space_kinematic_body.velocity.length() > 0.0:
				return
			var jump_velocity = Vector2.UP.rotated(space_kinematic_body.rotation) * 500
			space_kinematic_body.velocity = jump_velocity
		else:
			var normal = space_kinematic_body.velocity.normalized()
			
			print(normal.angle())
