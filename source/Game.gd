extends Node

"""
Controls game's flow
"""

onready var _interface = $Interface

func _ready():
	Achievements.connect("achievement_completed", self, "_on_Achievements_achievement_completed")
	$FullmoonAchievement.check_achievement()


func _on_Level_game_over(level):
	var score_screen = load("res://screens/score_screen/ScoreScreen.tscn")
	_interface.change_screen(score_screen)
	level.queue_free()


func _on_Interface_screen_changed(new_screen):
	match new_screen.name:
		"PlayScreen":
			var level = load("res://levels/Level.tscn").instance()
			level.connect("game_over", self, "_on_Level_game_over", [level])
			add_child(level)
		"ScoreScreen":
			var score = Score.current_score
			var highscore = Score.high_score
			Score.set_score(0)
			
			new_screen.set_score(score)
			new_screen.set_highscore(highscore)
			Achievements.write_achievements()


func _on_Achievements_achievement_completed(achievement_name):
	var panel = $Achievements/SlidingPanel
	
	panel.description = Achievements.get_description(achievement_name)
	panel.title = Achievements.get_title(achievement_name)
	Achievements.write_achievements()
	panel.show()
