extends "res://screens/abstract_screen.gd"

func _ready():
	acheesements.already_played = true
	get_node("ScreenMargin/ScreenPortions/TopPortion/Score").set_text("Score: %s" %Score.get_score())
	get_node("ScreenMargin/ScreenPortions/TopPortion/Highscore").set_text("Highscore: %s" %Score.read_highscore())

func _on_Back_released():
	change_to_next_scene("res://screens/Title_Screen/TitleScreen.tscn")
	Score.set_score(0)

func _on_Retry_button_up():
	change_to_next_scene("res://screens/Play_Screen/PlayScreen.tscn")
	Score.set_score(0)