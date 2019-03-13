extends Control

onready var description_label = $Description
onready var title_label = $Title

func _ready():
	acheesements.read_achievements()

func display(achievement):
	var title = acheesements.dict[achievement].name
	var description = acheesements.dict[achievement].description
	var accomplished = acheesements.dict[achievement].accomplished
	var total = acheesements.dict[achievement].total
	title_label.text = title
	description_label.text = ("%s, you already accomplished: %s / %s" % [description, accomplished, total])
	show()
