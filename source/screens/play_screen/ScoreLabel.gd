extends Label

func _ready():
	Score.connect("scored", self, "_on_ScoreHandler_scored")


func _on_ScoreHandler_scored():
	text = "Score: %s" % Score.current_score
