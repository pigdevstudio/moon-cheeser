extends Area2D

signal dragging()
signal dragged(direction)

var direction = Vector2()
var is_dragging = false

func _ready():
	set_process_unhandled_input(false)


func _unhandled_input(event):
	if not event is InputEventMouseButton:
		return
		
	var is_left_click = event.button_index == 1
	if  is_left_click and not event.is_pressed():
		direction = (get_global_mouse_position() - global_position).normalized()
		emit_signal("dragged", direction)
		set_process_unhandled_input(false)


func _on_mouse_exited():
	if is_dragging:
		set_process_unhandled_input(true)


func _on_input_event(viewport, event, shape_idx):
	if viewport.is_input_handled():
		return
	
	if not event is InputEventMouseButton:
		return
	
	var is_left_click = event.button_index == 1
	if not is_left_click:
		return
	
	if event.is_pressed():
		is_dragging = true
		set_process_unhandled_input(true)
		emit_signal("dragging")
	else:
		emit_signal("dragged", direction)
