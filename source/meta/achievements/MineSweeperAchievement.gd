extends "res://meta/achievements/AchievementTrigger.gd"

func _on_Crater_ready():
	var craters_group = get_tree().get_nodes_in_group("crater")
	var craters_amount = craters_group.size()
	if craters_amount >= 5:
		increase_progress()
