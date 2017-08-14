extends TextureButton

export (Color) var normal
export (Color) var hover
export (Color) var pressed

func _on_mouse_exit():
	set_modulate(normal)

func _on_mouse_enter():
	set_modulate(hover)

func _on__button_down():
	set_modulate(pressed)

func _on_button_up():
	set_modulate(hover)
