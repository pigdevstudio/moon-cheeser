extends "res://meta/achievements/AchievementTrigger.gd"

func _on_BlackHole_tree_exiting():
	increase_progress()
