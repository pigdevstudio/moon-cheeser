extends "res://meta/achievements/AchievementTrigger.gd"

var _dragged = false
var _moon_collided = false

func _on_DragArea_dragging():
	_dragged = true

func _on_KillingArea_body_entered(body):
	_moon_collided = body.is_in_group("moon")
	if _dragged and _moon_collided:
		increase_achievement_progress()
