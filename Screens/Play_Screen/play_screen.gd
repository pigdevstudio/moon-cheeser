extends "res://Screens/abstract_screen.gd"

func _on_scored( amount ):
	score_handler.set_score(amount)
	var score = score_handler.get_score()
	get_node("Score").set_text("Score: %s" %score)

	
func set_aspect():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_KEEP,
	Vector2(1280, 720))