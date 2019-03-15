extends "res://screens/Screen.gd"

onready var _score_label = $MarginContainer/VBoxContainer/HBoxConttainer/Labels/Score
onready var _highscore_label = $MarginContainer/VBoxContainer/HBoxConttainer/Labels/Highscore

func set_score(score):
	_score_label.text = "score: %s"%score

func set_highscore(highscore):
	_highscore_label.text = "highscore: %s"%highscore
