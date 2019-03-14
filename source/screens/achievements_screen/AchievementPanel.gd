extends Control

onready var description_label = $MarginContainer/VBoxContainer/Description
onready var title_label = $MarginContainer/VBoxContainer/Title

func _ready():
	Achievements.read_achievements()

func display(achievement):
	var title = Achievements.get_title(achievement)
	var description = Achievements.get_description(achievement)
	var progress = Achievements.get_progress(achievement)
	var total = Achievements.get_goal(achievement)
	
	title_label.text = title.to_lower()
	
	var description_text = "%s, you already accomplished: %s / %s"
	description_text = description_text % [description, progress, total]
	description_text = description_text.to_lower()
	description_label.text = description_text
	show()
