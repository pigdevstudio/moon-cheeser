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
extends Node

var dict = {}
export (String, FILE) var file_path
var file = File.new()
var text
var already_played = false
onready var popup = get_node("Panel")
onready var timer = get_node("Timer")
onready var tween = get_node("Tween")

func _ready():
	var t = Translation.new()
	t.set_locale("pt_BR")
	print(file_path)
	read_achievements()

func read_achievements():
	if file.file_exists("user://achievements.json"):
		file.open("user://achievements.json", file.READ)
		text = file.get_as_text()
		dict.parse_json(text)
		file.close()
	else:
		file.open(file_path, file.READ)
		text = file.get_as_text()
		dict.parse_json(text)
		file.close()
		file.open("user://achievements.json", file.WRITE)
		write_achievements()
		file.close()

func write_achievements():
	if file.file_exists("user://achievements.json"):
		file.open("user://achievements.json", file.WRITE)
		file.store_string(dict.to_json())
		file.close()

func modify_achievement(achievement, value):
	if value == 0:
		dict[achievement].accomplished = 0
	if dict[achievement].accomplished < dict[achievement].total: 
		dict[achievement].accomplished += value
		if dict[achievement].accomplished >= dict[achievement].total: 
			popup.get_node("Title").set_text("ACHEESEMENT UNLOCKED")
			popup.get_node("Label").set_text(dict[achievement].name)
			_show_popup()

func _show_popup():
	popup.show()
	tween.interpolate_property(popup, "rect/pos", popup.get_pos(), popup.get_pos() + Vector2(0, 100),
	0.5, tween.TRANS_BACK, tween.EASE_OUT)
	tween.start()
	timer.start()
	
func _hide_popup():
	tween.interpolate_property(popup, "rect/pos", popup.get_pos(), popup.get_pos() - Vector2(0, 100),
	0.5, tween.TRANS_BACK, tween.EASE_IN)
	tween.start()
	yield(tween, "tween_complete")
	popup.hide()

func _on_Timer_timeout():
	_hide_popup()

func _on_hide():
	tween.interpolate_property(popup, "rect/pos", popup.get_pos(), popup.get_pos() - Vector2(0, 100),
	0.5, tween.TRANS_BACK, tween.EASE_IN)
	tween.start()
	yield(tween, "tween_complete")
	popup.hide()
