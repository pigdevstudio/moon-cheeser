extends Area2D

signal dragging()
signal dragged(direction)

func _ready():
	set_process_unhandled_input(false)


func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		set_process_unhandled_input(true)
		emit_signal("dragging")


func _unhandled_input(event):
	if event.is_action_released("click"):
		var direction = global_position.direction_to(get_global_mouse_position())
		emit_signal("dragged", direction)
		set_process_unhandled_input(false)
