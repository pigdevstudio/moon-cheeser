extends HTTPRequest

var token
var player_id


func authenticate_guest_session():
	var url = "https://api.lootlocker.io/game/v2/session/guest"
	var header = ["Content-Type: application/json"]
	var method = HTTPClient.METHOD_POST
	var request_body = {
		"game_key" : "7393effcf75bb8c278817169778785a4d68e8ebe",
		"game_version" : "2.1.0",
		"player_identifier" : player_id,
		"development_mode" : true
		}
	
	NetworkStateLabel.show_authentication()
	
	request(url, header, false, method, to_json(request_body))
	
	var response = yield(self, "request_completed")[3]
	response = JSON.parse(response.get_string_from_utf8()).result
	
	if "session_token" in response:
		token = response["session_token"]
		NetworkStateLabel.show_login_successful()
	else:
		NetworkStateLabel.show_authentication_failed()
