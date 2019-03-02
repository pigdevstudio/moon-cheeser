extends Label

func _ready():
	Score.connect("scored", self, "_on_ScoreHandler_scored")
	
func _on_ScoreHandler_scored():
	var score = str(Score.get_score())
	text = "Score: %s"%[score]
