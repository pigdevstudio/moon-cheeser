extends Panel

onready var tween = $Tween
onready var timer = $IdleTime

onready var title = $MarginContainer/VBoxContainer/Title setget set_title, get_title
onready var description = $MarginContainer/VBoxContainer/Description setget set_description, get_description

export (float) var slide_distance = 200.0

func _ready():
	slide_distance += rect_size.y

func set_title(new_title):
	title.text = new_title.to_lower()

func get_title():
	return title.text

func set_description(new_description):
	description.text = new_description.to_lower()

func get_description():
	return description.text

func show():
	.show()
	var initial_position = rect_position
	var final_position = rect_position + Vector2(0, slide_distance)
	var tween_duration = 0.5
	tween.interpolate_property(self, "rect_position", initial_position, final_position,
			tween_duration, tween.TRANS_BACK, tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
	timer.start()

func hide():
	var initial_position = rect_position
	var final_position = rect_position - Vector2(0, slide_distance)
	var tween_duration = 0.5
	tween.interpolate_property(self, "rect_position", initial_position, final_position,
			tween_duration, tween.TRANS_BACK, tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	.hide()
