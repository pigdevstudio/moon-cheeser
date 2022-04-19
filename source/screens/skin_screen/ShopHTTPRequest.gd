extends HTTPRequest

var skins_scenes_url = []
var skins_images_url = []


func load_skins():
	request(
		"https://api.lootlocker.io/game/v1/assets/list?count=50&filter=purchasable",
		["Content-Type: application/json", "x-session-token: %s" % LootLocker.token],
		false,
		HTTPClient.METHOD_GET
		)
	var response = yield(self, "request_completed")[3]
	response = JSON.parse(response.get_string_from_utf8()).result
	for asset in response['assets']:
		skins_scenes_url.append(asset['files'][0]['url'])
		skins_images_url.append(asset['files'][1]['url'])


func get_image(image_url):
	request(image_url, [image_url])


func get_skin_scene(skin_scene_url):
	request(skin_scene_url, [skin_scene_url])
