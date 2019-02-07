#MIT License
#
#Copyright (c) 2017 Pigdev Studio
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.
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
