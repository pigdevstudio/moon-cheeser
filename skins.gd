extends Node
var dict = {}
var file = File.new()
var text

var star_skin       = "res://Actors/Star/star.png"
var comet_skin      = "res://Actors/Comet/comet.png"
var starmouse_skin  = "res://Actors/Astromouse/starmouse.png"
var astromouse_skin = "res://Actors/Astromouse/astromouse_new.png"
var moon_skin       = "res://Actors/Moon/moon.png"
var cheese_skin     = "res://Objects/Cheese/cheese.png"
var crater_skin     = "res://Objects/Crater/crater.png"
var planet_skin     = "res://Actors/Planet/planet.png"

func _ready():
	read_skins()
func read_skins():
	if file.file_exists("res://Screens/Achievements_Screen/skins.json"):
		file.open("res://Screens/Achievements_Screen/skins.json", file.READ)
		text = file.get_as_text()
		dict.parse_json(text)
		file.close()