extends Node

var dict = {}
var file = File.new()
var text

onready var popup = get_node("Popup")
onready var timer = get_node("Timer")
onready var tween = get_node("Tween")

func _ready():
	read_achievements()

func read_achievements():
	if file.file_exists("res://Screens/Achievements_Screen/achievements.json"):
		file.open("res://Screens/Achievements_Screen/achievements.json", file.READ)
		text = file.get_as_text()
		dict.parse_json(text)
		file.close()

func write_achievements():
	if file.file_exists("res://Screens/Achievements_Screen/achievements.json"):
		file.open("res://Screens/Achievements_Screen/achievements.json", file.WRITE)
		file.store_string(dict.to_json())
		file.close()
		print("done")

func modify_achievement(achievement, value):
	dict[achievement].accomplished += value
	if dict[achievement].accomplished >= dict[achievement].total:
		if achievement == "achievementthree":
			skins.dict["cheese_star"] = true
			popup.set_title("Acheesement unlocked!")
			popup.set_text(dict[achievement].name)
			_show_popup()

func _on_timeout():
	_hide_popup()

func _show_popup():
	popup.popup()
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