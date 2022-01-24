extends Area2D

signal dragging()
signal dragged(direction)

var pressed = false

func _ready():
	set_process_unhandled_input(false)


func _input_event(viewport, event, shape_idx):
	if not event.is_pressed():
		return
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		emit_signal("dragging")
		pressed = true
		set_process_unhandled_input(true)
		get_tree().set_input_as_handled()


func _unhandled_input(event):
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		if event.is_pressed():
			emit_signal("dragging")
			pressed = true
			get_tree().set_input_as_handled()
		if not event.is_pressed():
			var direction = Vector2.ZERO
			if event is InputEventMouseButton:
				direction = global_position.direction_to(get_global_mouse_position())
				get_tree().set_input_as_handled()
				pressed = false
			if event is InputEventScreenTouch:
				direction = event.position
				get_tree().set_input_as_handled()
				pressed = false
			emit_signal("dragged", direction)
			set_process_unhandled_input(false)
		
