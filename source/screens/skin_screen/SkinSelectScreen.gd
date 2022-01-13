extends Control


func _ready():
	for button in $GridContainer.get_children():
		button.connect("skin_selected", self, "set_new_skin")


func set_new_skin(new_skin, type):
	Skins.set(type, new_skin)
