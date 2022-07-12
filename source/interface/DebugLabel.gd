extends CanvasLayer


var text setget set_text

onready var _label = $Panel/Label
onready var _panel = $Panel


func set_text(new_text):
	text = new_text
	_label.text = text
#	_panel.show()
	_panel.rect_size = _label.rect_size


func _on_Button_pressed():
	_panel.hide()
