extends "res://meta/achievements/AchievementTrigger.gd"

func _on_PickupArea_area_entered(area):
	if area.is_in_group("cheese"):
		increase_achievement_progress()
