extends "res://Screens/abstract_screen.gd"

func _ready():
	acheesements.modify_achievement("gravity", 0)
	get_node("ScreenMargin/ScreenPortions/TopPortion/Score").set_text("Score: %s" %score_handler.get_score())
	get_node("ScreenMargin/ScreenPortions/TopPortion/Highscore").set_text("Highscore: %s" %score_handler.read_highscore())

func _on_Retry_released():
	change_to_next_scene("res://Screens/Play_Screen/PlayScreen.tscn")
	score_handler.set_score(0)

func _on_Back_released():
	change_to_next_scene("res://Screens/Title_Screen/TitleScreen.tscn")
	score_handler.set_score(0)