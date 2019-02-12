extends Area2D
signal dragging()
signal dragged(direction)

var direction = Vector2()

func _ready():
	set_process_unhandled_input(false)

func _on_DragArea_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		emit_signal("dragging")
		
	elif event.is_action_released("click"):
		emit_signal("dragged", direction)

func _unhandled_input(event):
	if event.is_action_released("click"):
		direction = (get_global_mouse_position() - global_position).normalized()
		emit_signal("dragged", direction)
		set_process_unhandled_input(false)
