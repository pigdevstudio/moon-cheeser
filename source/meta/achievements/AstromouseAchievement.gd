extends "res://meta/achievements/AchievementTrigger.gd"

func _on_PickupArea_area_entered(area):
	increase_progress()
