extends Control

export(String, FILE, "*.tscn") var game_scene_path
export(String, FILE, "*.tscn") var main_scene_path

onready var _score_label = $ScoreLabel
onready var _highscore_label = $HighScoreLabel
onready var _fade = $FadeRect
onready var _admob = $AdMob


func _ready():
	set_score(Score.current_score)
	set_highscore(Score.high_score)


func set_score(score):
	_score_label.text = "score: %s" % score


func set_highscore(highscore):
	_highscore_label.text = "highscore: %s" % highscore


func _on_RetryButton_pressed():
	yield(_fade.fade_out(), "completed")
	if OS.get_name() == "Android":
		_admob.load_rewarded_video()
		yield(_admob, "rewarded_video_loaded")
		_admob.show_rewarded_video()
		var reward = yield(_admob, "rewarded")[1]
	get_tree().change_scene(game_scene_path)


func _on_BackButton_pressed():
	_fade.change_scene(main_scene_path)
