extends Control


export (PackedScene) var board_entry_scene

onready var player_list = $ScorePanel/ScrollContainer/PlayersList
onready var http_request = $LeaderboardHTTPRequest
onready var fade_rect = $FadeRect


func _ready():
	NetworkStateLabel.show_loading_board()
	yield(http_request.get_board(), "completed")
	for i in http_request.board:
		var entry = board_entry_scene.instance()
		entry.player_name = i['metadata']
		entry.player_score = i['score']
		player_list.add_child(entry)
	NetworkStateLabel.show_board_loaded()


func _on_BackButton_pressed():
	fade_rect.change_scene()
