extends Control


onready var highscore_label = $HighscoreLabel
onready var fade_rect = $FadeRect
onready var line_edit = $LineEdit
onready var http_request = $HighscoreHTTPRequest


func _ready():
	highscore_label.text = "%s" % Score.current_score


func _on_SubmitButton_pressed():
	fade_rect.fade_out()
	http_request.request(
		"https://api.lootlocker.io/game/leaderboards/moon-cheeser/submit",
		["Content-Type: application/json", "x-session-token: %s" % LootLocker.token],
		false,
		HTTPClient.METHOD_POST,
		"{\"score\": %s, \"member_id\": \"%s\", \"metadata\": \"%s\"}" % [Score.high_score, LootLocker.player_id, line_edit.text])
	yield(http_request, "request_completed")
	get_tree().change_scene(fade_rect.next_scene_path)
