extends "res://screens/Screen.gd"

onready var _score_label = $MarginContainer/VBoxContainer/Score
onready var _highscore_label = $MarginContainer/VBoxContainer/Highscore

func set_score(score):
	_score_label.text = "score: %s"%score

func set_highscore(highscore):
	_highscore_label.text = "highscore: %s"%highscore
