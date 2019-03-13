extends "res://screens/Screen.gd"

func _ready():
	var achievements_button = $ScreenMargin/ScreenPortions/LeftPortion/Achievements
	var credits_button = $ScreenMargin/ScreenPortions/CenterPortion/Credits
	var play_button = $ScreenMargin/ScreenPortions/RightPortion/Play
	
	var buttons = []
	buttons.append(achievements_button)
	buttons.append(credits_button)
	buttons.append(play_button)
	
	
