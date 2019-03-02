extends "res://screens/abstract_screen.gd"

var date = OS.get_date()
var release = {"day":05, "month": 10, "year": 2017, "hour": 15, "minute": 41, "second": 23}

func _ready():
	date = OS.get_unix_time_from_datetime(date)
	release = OS.get_unix_time_from_datetime(release)
	var dif = (((date - release) / 60.0) / 60.0) / 24.0
	dif = dif / ceil(dif / 30)
	if  dif >= 29.0 and dif <= 30.0:
		acheesements.modify_achievement("fullmoon", 1)
		acheesements.write_achievements()

func _on_Credits_pressed():
	if OS.get_name() == "Android":
		change_to_next_scene("res://screens/Credits_Screen/CreditsScreen.tscn")

func _on_Play_pressed():
	if OS.get_name() == "Android":
		change_to_next_scene("res://screens/Play_Screen/PlayScreen.tscn")

func _on_Achievements_pressed():
	if OS.get_name() == "Android":
		change_to_next_scene("res://screens/Achievements_Screen/AchievementsScreen.tscn")
