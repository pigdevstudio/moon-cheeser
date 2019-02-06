extends Node

var current_score = 0 setget set_score, get_score
var high_score = 0

signal scored
func _ready():
	var f = File.new()
	if f.file_exists("user://highscore"):
		f.open("user://highscore", f.READ)
		high_score = f.get_var()
		f.close()
	else:
		f.open("user://highscore", f.WRITE)
		f.store_var(high_score)
		f.close()

func set_score(value):
	if value > 0:
		current_score += value
		
		if current_score > high_score:
			high_score = current_score
			write_highscore()
	else:
		current_score = 0
	emit_signal("scored")

func get_score():
	return(current_score)
	
func write_highscore():
	var f = File.new()
	if f.file_exists("user://highscore"):
		f.open("user://highscore", f.WRITE)
		f.store_var(high_score)
		f.close()

func read_highscore():
	var f = File.new()
	if f.file_exists("user://highscore"):
		f.open("user://highscore", f.READ)
		high_score = f.get_var()
		f.close()
	return(high_score)
