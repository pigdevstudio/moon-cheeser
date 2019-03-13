extends Node

"""
Controls game's flow
"""

onready var _interface = $Interface

func _on_Level_game_over(level):
	var score_screen = load("res://screens/score_screen/ScoreScreen.tscn")
	_interface.change_screen(score_screen)
	level.queue_free()


func _on_Interface_screen_changed(new_screen):
	match new_screen.name:
		"PlayScreen":
			var level = load("res://levels/MoonLevel.tscn").instance()
			level.connect("game_over", self, "_on_Level_game_over", [level])
			add_child(level)
		"ScoreScreen":
			var score = Score.current_score
			var highscore = Score.high_score
			
			new_screen.set_score(score)
			new_screen.set_highscore(highscore)
