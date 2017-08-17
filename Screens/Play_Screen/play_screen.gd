extends "res://Screens/abstract_screen.gd"

func _ready():
	score_handler.connect("scored", self, "_on_scored")

func _on_scored():
	var score = score_handler.get_score()
	get_node("Score").set_text("Score: %s" %score)

func set_aspect():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_KEEP,
	Vector2(1280, 720))