extends Node

export (String) var achievement_name

func increase_progress():
	var current_progress = Achievements.get_progress(achievement_name)
	Achievements.set_achievement_progress(achievement_name, current_progress + 1)
