extends Control

onready var description_label = $MarginContainer/VBoxContainer/Description
onready var title_label = $MarginContainer/VBoxContainer/Title

func _ready():
	acheesements.read_achievements()

func display(achievement):
	var title = acheesements.dict[achievement].name
	var description = acheesements.dict[achievement].description
	var accomplished = acheesements.dict[achievement].accomplished
	var total = acheesements.dict[achievement].total
	
	title_label.text = title.to_lower()
	
	var description_text = "%s, you already accomplished: %s / %s"
	description_text = description_text % [description, accomplished,
			total]
	description_text = description_text.to_lower()
	description_label.text = description_text
	
	show()
