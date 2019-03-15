extends "res://meta/achievements/AchievementTrigger.gd"

func _on_Comet_collided(collision):
	var collider = collision.collider
	
	if collider.is_in_group("moon"):
		increase_achievement_progress()
