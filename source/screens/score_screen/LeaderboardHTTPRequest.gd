extends HTTPRequest


var board

func get_board():
	request(
		"https://api.lootlocker.io/game/leaderboards/moon-cheeser/list?count=10",
		["Content-Type: application/json", "x-session-token: %s" % LootLocker.token],
		false,
		HTTPClient.METHOD_GET)
	yield(self, "request_completed")


func _on_request_completed(result, response_code, headers, body):
	var response = JSON.parse(body.get_string_from_utf8()).result
	if "items" in response:
		board = response["items"]
