extends HTTPRequest

var token
var player_id


func authenticate_guest_session():
	var request = {
		"game_key" : "c1e00ac7c442d91259504cdff4363152a4088781",
		"player_identifier" : player_id,
		"game_version" : "2.1.0",
		"development_mode" : true
		}
	
	NetworkStateLabel.show_authentication()
	request(
		"https://api.lootlocker.io/game/v2/session/guest",
		["Content-Type: application/json"],
		false,
		HTTPClient.METHOD_POST,
		to_json(request)
		)
	
	var response = yield(self, "request_completed")[3]
	response = JSON.parse(response.get_string_from_utf8()).result
	if "session_token" in response:
		token = response["session_token"]
	NetworkStateLabel.show_login_successful()
