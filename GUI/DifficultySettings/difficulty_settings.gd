extends VBoxContainer

func _ready():
	settings.set_difficulty(0)
	_on_difficulty_change(0)
func _on_difficulty_change( value ):
	settings.set_difficulty(value)
	if value == 0:
		get_node("Label").set_text("EASY")
	elif value == 1:
		get_node("Label").set_text("NORMAL")
	elif value == 2:
		get_node("Label").set_text("HARD")
	elif value == 3:
		get_node("Label").set_text("EXTREME")
	elif value == 4:
		get_node("Label").set_text("INSANE")