extends HTTPRequest

var skins_scenes_url = []
var skins_images_url = []


func load_player_inventory():
	request(
		"https://api.lootlocker.io/game/v1/player/inventory/list",
		["Content-Type: application/json", "x-session-token: %s" % LootLocker.token],
		false,
		HTTPClient.METHOD_GET
		)
	var response = yield(self, "request_completed")[3]
	response = JSON.parse(response.get_string_from_utf8()).result
	for asset in response['inventory']:
		skins_scenes_url.append(asset['asset']['files'][0]['url'])
		skins_images_url.append(asset['asset']['files'][1]['url'])


func get_image(image_url):
	request(image_url, [image_url])


func get_skin_scene(skin_scene_url):
	request(skin_scene_url, [skin_scene_url])
