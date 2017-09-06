extends Control
onready var popup = get_parent().get_node("Panel")
func _ready():
	acheesements.read_achievements()
	skins.read_skins()

func call_popup(achievement):
	var title = acheesements.dict[achievement].name
	var description = acheesements.dict[achievement].description
	var accomplished = acheesements.dict[achievement].accomplished
	var total = acheesements.dict[achievement].total
	popup.get_node("Title").set_text(title)
	popup.get_node("Label").set_text("%s, you already accomplished: %s / %s" % [description, accomplished, total])
	popup.show()