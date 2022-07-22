extends Node2D

signal mouse_found(global_mouse_position)
signal mouse_lost
signal mouse_moved(global_mouse_position)

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		emit_signal("mouse_moved", event.position)

	elif not event is InputEventMouse:
		return
	
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			emit_signal("mouse_found", get_global_mouse_position())
		elif event.button_index == 1 and not event.pressed:
			emit_signal("mouse_lost")
	
	elif event is InputEventMouseMotion:
		if Input.is_action_pressed("click") and event is InputEventMouseMotion:
			emit_signal("mouse_moved", get_global_mouse_position())
