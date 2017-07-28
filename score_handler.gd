extends Node

var current_score = 0 setget set_score, get_score

func set_score(value):
	if value > 0:
		current_score += value
	else:
		current_score = value
	print(current_score)

func get_score():
	return(current_score)
	
func player_died():
	set_score(0)