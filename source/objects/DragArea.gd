extends Area2D

signal dragging()
signal dragged(direction)

var direction = Vector2()
var is_dragging = false

func _ready():
	set_process_unhandled_input(false)


func _unhandled_input(event):
	if event.is_action_released("click"):
		direction = (get_global_mouse_position() - global_position).normalized()
		emit_signal("dragged", direction)
		set_process_unhandled_input(false)


func _on_mouse_exited():
	if is_dragging:
		set_process_unhandled_input(true)


func _on_input_event(viewport, event, shape_idx):
	if viewport.is_input_handled():
		return
	
	if event.is_action_pressed("click"):
		is_dragging = true
		emit_signal("dragging")
		
	elif event.is_action_released("click"):
		emit_signal("dragged", direction)
