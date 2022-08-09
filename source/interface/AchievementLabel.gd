extends CanvasLayer


export(String, MULTILINE) var text = "insert text here" setget set_text

onready var label = $Label
onready var animation_player = $AnimationPlayer
onready var timer = $Timer


func set_text(new_text):
	text = new_text
	if not label:
		yield(self, "ready")
	label.text = text


func show(time = -1.0):
	animation_player.play("appear")
	
	if time > 0.0:
		timer.start(time)


func hide():
	animation_player.play("disappear")


func _on_Timer_timeout():
	hide()
