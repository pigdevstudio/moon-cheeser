extends Control

func _ready():
	unlock_skins()
func change_skin(skin, new):
	skins.set(skin, new)
	
func unlock_skins():
	for key in skins.dict:
		if key == "cheese_star" and skins.dict[key] == true:
			get_node("GridContainer/Skin#1").show()