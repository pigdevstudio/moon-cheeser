extends HTTPRequest


var token
var player_id

func _ready():
	var file = File.new()
	if (file.file_exists("user://player_data.json")):
		file.open("user://player_data.json", File.READ)
		var player_data = parse_json(file.get_as_text())
		token = player_data['token']
		player_id = player_data['player_identifier']
		authenticate_session()
	else:
		register_new_session()


func authenticate_session():
	request(
		"https://api.lootlocker.io/game/v2/session/guest",
		["Content-Type: application/json"],
		false,
		HTTPClient.METHOD_POST,
		"{\"game_key\": \"c1e00ac7c442d91259504cdff4363152a4088781\", \"player_identifier\": \"%s\", \"game_version\": \"2.1.0\", \"development_mode\": \"true\"}" % player_id
		)
	var response = yield(self, "request_completed")[3]
	response = JSON.parse(response.get_string_from_utf8()).result
	if "session_token" in response:
		token = response["session_token"]
	if "player_identifier" in response:
		player_id = response["player_identifier"]
	store_player_data()


func store_player_data():
	var player_data = {"token": token, "player_identifier": player_id}
	
	var file = File.new()
	file.open("user://player_data.json", File.WRITE)
	file.store_string(to_json(player_data))
	file.close()


func register_new_session():
	request(
		"https://api.lootlocker.io/game/v2/session/guest",
		["Content-Type: application/json"],
		false,
		HTTPClient.METHOD_POST,
		"{\"game_key\": \"c1e00ac7c442d91259504cdff4363152a4088781\", \"game_version\": \"2.1.0\", \"development_mode\": \"true\"}"
		)
	var response = yield(self, "request_completed")[3]
	response = JSON.parse(response.get_string_from_utf8()).result
	if "session_token" in response:
		token = response["session_token"]
	if "player_id" in response:
		player_id = response["player_identifier"]
	store_player_data()
