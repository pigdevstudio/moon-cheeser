extends HTTPRequest


var board

func get_board():
	NetworkStateLabel.show_loading_board()
	
	var url = "https://api.lootlocker.io/game/leaderboards/2120/list?count=10"
	var header = ["Content-Type: application/json", "x-session-token: %s" % LootLocker.token]
	var method = HTTPClient.METHOD_GET

	request(url, header, false, method)
	
	var response = yield(self, "request_completed")[3]
	response = JSON.parse(response.get_string_from_utf8()).result
	
	if "items" in response:
		board = response["items"]
