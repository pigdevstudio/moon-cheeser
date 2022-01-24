extends Control

onready var fade_rect = $FadeRect

func _ready():
	for button in $ScrollContainer/GridContainer.get_children():
		button.connect("skin_selected", self, "set_new_skin")
	for button in $ScrollContainer2/GridContainer.get_children():
		button.connect("skin_selected", self, "set_new_skin")

func set_new_skin(new_skin, type):
	Skins.set(type, new_skin)


func _on_BackButton_pressed():
	fade_rect.change_scene()
