extends Area2D

signal dragging()
signal dragged(direction)

var direction = Vector2()

func _ready():
	set_process_input(false)


func _input(event):
	if not event.is_action("click"):
		return
	if not event.is_pressed():
		direction = global_position.direction_to(get_global_mouse_position())
		emit_signal("dragged", direction)
		set_process_input(false)
		input_pickable = false


func _on_input_event(viewport, event, shape_idx):
	if not event.is_action("click"):
		return
	if event.is_pressed():
		set_process_input(true)
		emit_signal("dragging")
	else:
		emit_signal("dragged", direction)
