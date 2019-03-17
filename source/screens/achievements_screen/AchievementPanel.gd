extends Control

onready var description = $MarginContainer/VBoxContainer/Description setget set_description, get_description
onready var title = $MarginContainer/VBoxContainer/Title setget set_title, get_title

func _ready():
	Achievements.read_achievements()

func display(achievement):
	var achievement_title = Achievements.get_title(achievement)
	var achievement_description = Achievements.get_description(achievement)
	var achievement_progress = Achievements.get_progress(achievement)
	var achievement_goal = Achievements.get_goal(achievement)
	
	var description_text = "%s, you already accomplished: %s / %s"
	description_text = description_text % [achievement_description,
			achievement_progress, achievement_goal]
	
	set_title(achievement_title)
	set_description(description_text)
	show()

func set_title(new_title):
	title.text = new_title.to_lower()
	
func get_title():
	return title.text

func set_description(new_description):
	description.text = new_description.to_lower()
	
func get_description():
	return description.text