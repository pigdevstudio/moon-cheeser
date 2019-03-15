extends Control
"""
A set of user interface elements.
"""
signal faded
signal button_up(button)

onready var _fade = $Fade

func _ready():
	var buttons = get_tree().get_nodes_in_group("screen_button")
	for button in buttons:
		button.connect("button_up", self, "_on_button_up", [button])

func _on_button_up(button):
	emit_signal("button_up", button)

func fade_in():
	_fade.fade_in()
	yield(_fade, "finished")
	emit_signal("faded")

func fade_out():
	_fade.fade_out()
	yield(_fade, "finished")
	emit_signal("faded")

func is_fading():
	var animator = _fade.animator
	return animator.is_playing()
