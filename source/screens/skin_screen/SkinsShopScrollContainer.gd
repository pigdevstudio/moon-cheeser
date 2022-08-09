extends ScrollContainer

signal asset_purchased

export(PackedScene) var skin_button

onready var http_request = $HTTPRequest
onready var google_billing = $GooglePlayBilling
onready var grid = $GridContainer



func load_skins():
	var url = "https://api.lootlocker.io/game/v1/assets/list?count=50&filter=purchasable"
	var header = ["Content-Type: application/json", "x-session-token: %s" % LootLocker.token]
	var method = HTTPClient.METHOD_GET
	http_request.request(url, header, false, method)

	var response = yield(http_request, "request_completed")[3]
	response = JSON.parse(response.get_string_from_utf8()).result
	for asset in response['assets']:
		var scene_url = asset['files'][0]['url']
		var image_url = asset['files'][1]['url']
		var asset_id = asset['id']
		var playstore_id = asset["external_identifiers"]["google_play"]["product_id"]
		create_skin_button(scene_url, image_url, asset_id, playstore_id)


func create_skin_button(scene_url, image_url, asset_id, playstore_id):
	var button = skin_button.instance()
	button.skin_image_url = image_url
	button.skin_scene_url = scene_url
	button.asset_id = asset_id
	button.playstore_id = playstore_id
	grid.add_child(button)
	button.connect("pressed", self, "_on_SkinButton_pressed", [asset_id, playstore_id])


func purchase(asset_id, purchase_token):
	var url = "https://api.lootlocker.io/game/v1/purchase"
	var header = ["Content-Type: application/json", "x-session-token: %s" % LootLocker.token]
	var method = HTTPClient.METHOD_POST
	var request_data = {
		"asset_id" : asset_id,
		"purchase_token" : purchase_token
	}
	http_request.request(url, header, false, method, to_json(request_data))
	var response = yield(self, "request_completed")[3]
	response = JSON.parse(response.get_string_from_utf8()).result
	NetworkStateLabel.show_purchased()
	emit_signal("asset_purchased")


func _on_SkinButton_pressed(asset_id, playstore_id):
	NetworkStateLabel.show_purchasing()
	google_billing.payment.querySkuDetails([playstore_id], "inapp")
	yield(google_billing.payment, "sku_details_query_completed")
	google_billing.payment.purchase(playstore_id)
	var token = yield(google_billing, "purchase_token_retrieved")[0]
	purchase(asset_id, token)
