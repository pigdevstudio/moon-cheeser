extends Node

export (int,"EASY", "NORMAL", "HARD", "EXTREME", "INSANE") var difficulty = 0 setget set_difficulty, get_difficulty

func _ready():
	set_difficulty(0)

func set_difficulty(value):
	difficulty = value
	
func get_difficulty():
	return(difficulty)