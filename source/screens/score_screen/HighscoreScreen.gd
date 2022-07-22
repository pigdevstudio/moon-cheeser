extends Control


onready var highscore_label = $HighscoreLabel
onready var fade_rect = $FadeRect
onready var line_edit = $LineEdit
onready var http_request = $HighscoreHTTPRequest


func _ready():
	highscore_label.text = "%s" % Score.current_score


func submit_new_highscore():
	fade_rect.fade_out()

	var url = "https://api.lootlocker.io/game/leaderboards/4845/submit"
	var header = ["Content-Type: application/json", "x-session-token: %s" % LootLocker.token]
	var method = HTTPClient.METHOD_POST
	var request_data = {
		"score" : Score.high_score,
		"member_id" : LootLocker.player_id,
		"metadata" : line_edit.text
	}
	
	http_request.request(url, header, false, method, to_json(request_data))
	yield(http_request, "request_completed")
	
	get_tree().change_scene(fade_rect.next_scene_path)


func _on_SubmitButton_pressed():
	submit_new_highscore()


func _on_LineEdit_text_entered(new_text):
	submit_new_highscore()
