extends Node

var token
var player_id
var board

onready var http_request = $HTTPRequest


func _ready():
	http_request.request(
		"https://api.lootlocker.io/game/v2/session/guest",
		["Content-Type: application/json"],
		false,
		HTTPClient.METHOD_POST,
		"{\"game_key\": \"c1e00ac7c442d91259504cdff4363152a4088781\", \"game_version\": \"2.1.0\", \"development_mode\": \"true\"}"
		)
	yield(http_request, "request_completed")
	http_request.request(
		"https://api.lootlocker.io/game/leaderboards/moon-cheeser/submit",
		["Content-Type: application/json", "x-session-token: %s" % token],
		false,
		HTTPClient.METHOD_POST,
		"{\"score\": %s, \"member_id\": \"%s\"}" % [Score.high_score, player_id])
	yield(http_request, "request_completed")
	http_request.request(
		"https://api.lootlocker.io/game/leaderboards/moon-cheeser/list?count=10",
		["Content-Type: application/json", "x-session-token: %s" % token],
		false,
		HTTPClient.METHOD_GET)
	yield(http_request, "request_completed")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response = JSON.parse(body.get_string_from_utf8()).result
#	print(result)
#	print(response_code)
#	print(headers)
#	print(response)
	if "session_token" in response:
		token = response["session_token"]
	if "player_id" in response:
		player_id = response["player_id"]
	if "items" in response:
		board = response["items"]
