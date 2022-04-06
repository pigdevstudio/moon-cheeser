extends HTTPRequest


var token
var player_id

func _ready():
	request(
		"https://api.lootlocker.io/game/v2/session/guest",
		["Content-Type: application/json"],
		false,
		HTTPClient.METHOD_POST,
		"{\"game_key\": \"c1e00ac7c442d91259504cdff4363152a4088781\", \"game_version\": \"2.1.0\", \"development_mode\": \"true\"}"
		)


func _on_request_completed(result, response_code, headers, body):
	var response = JSON.parse(body.get_string_from_utf8()).result
	if "session_token" in response:
		token = response["session_token"]
	if "player_id" in response:
		player_id = response["player_id"]
