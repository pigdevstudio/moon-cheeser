class_name ShadedButton
extends TextureButton

export (Color) var normal_color = Color(1,1,1,1)
export (Color) var hover_color = Color(1.3,1.3,1.3,1)
export (Color) var pressed_color = Color(0.8,0.8,0.8,1)


func _ready():
	connect("button_down", self, "_on_button_down")
	connect("button_up", self, "_on_button_up")
	connect("mouse_entered", self, "_on_mouse_enter")
	connect("mouse_exited", self, "_on_mouse_exit")


func _on_mouse_exit():
	set_modulate(normal_color)


func _on_mouse_enter():
	set_modulate(hover_color)


func _on_button_down():
	set_modulate(pressed_color)


func _on_button_up():
	set_modulate(hover_color)

