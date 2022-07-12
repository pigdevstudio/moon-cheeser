extends HTTPRequest

var skins_scenes_url = []
var skins_images_url = []
var skins_ids = []
var skins_playstore_ids = []


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
		skins_ids.append(asset['id'])
		skins_playstore_ids.append(asset["external_identifiers"]["google_play"]["product_id"])


func get_image(image_url):
	request(image_url, [image_url])


func get_skin_scene(skin_scene_url):
	request(skin_scene_url, [skin_scene_url])


func purchase(asset_id, purchase_token):
	NetworkStateLabel.show_purchasing()
	request(
		"https://api.lootlocker.io/game/v1/purchase",
		["Content-Type: application/json", "x-session-token: %s" % LootLocker.token],
		false,
		HTTPClient.METHOD_POST,
		"[{\"asset_id\": %s, \"purchase_token\": \"%s\"}]" % [asset_id, purchase_token]
		)
	var response = yield(self, "request_completed")[3]
	response = JSON.parse(response.get_string_from_utf8()).result
	NetworkStateLabel.show_purchased()
