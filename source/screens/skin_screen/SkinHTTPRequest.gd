extends HTTPRequest

var loaded = false

func get_skins():
	request(
		"https://api.lootlocker.io/game/v1/assets/list?count=1&filter=purchasable",
		["Content-Type: application/json", "x-session-token: %s" % LootLocker.token],
		false,
		HTTPClient.METHOD_GET
		)


func _on_SkinHTTPRequest_request_completed(result, response_code, headers, body):
	if loaded == true:
		var file = File.new()
		file.open("user://skin.tscn", File.WRITE_READ)
		file.store_buffer(body)
		file.close()
		var skin = load("user://skin.tscn").instance()
		get_owner().add_child(skin)
		skin.position = Vector2(1280 / 2, 720 / 2)
		return

	var response = JSON.parse(body.get_string_from_utf8()).result

	if not 'assets' in response:
		return

	if 'files' in response['assets'][0]:
		for key in response['assets'][0]['files']:
			if key['url'].ends_with(".tscn"):
				request(key['url'], [key['url']])
				loaded = true
				break
