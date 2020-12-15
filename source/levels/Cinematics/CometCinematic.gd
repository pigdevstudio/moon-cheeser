extends Node

signal astromouse_died
signal finished


export (String, FILE, "*.tscn") var next_level_path


func _ready():
	BGM.stop()


func transit():
	emit_signal("finished")
