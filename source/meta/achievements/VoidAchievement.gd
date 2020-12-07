extends "res://meta/achievements/AchievementTrigger.gd"

func _on_KillingArea_body_killed():
	increase_progress()
