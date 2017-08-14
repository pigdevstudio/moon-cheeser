extends "res://GUI/ScreenMargin/screen_margin.gd"

func _ready():
	acheesements.read_achievements()
	skins.read_skins()

func call_popup(achievement):
	var title = acheesements.dict[achievement].name
	var description = acheesements.dict[achievement].description
	var accomplished = acheesements.dict[achievement].accomplished
	var total = acheesements.dict[achievement].total
	get_node("Dialog").set_title(title)
	get_node("Dialog").set_text("%s, you already accomplished: %s / %s" % [description, accomplished, total])
	get_node("Dialog").popup_centered()