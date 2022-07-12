extends Control

export(PackedScene) var skin_button

onready var shop_httprequest = $ShopHTTPRequest
onready var inventory_httprequest = $InventoryHTTPRequest
onready var shop_container = $ShopScrollContainer/GridContainer
onready var inventory_container = $InventoryScrollContainer/GridContainer
onready var fade_rect = $FadeRect
onready var google_billing = $GooglePlayBilling


func _ready():
	NetworkStateLabel.show_loading_skins()
	inventory_httprequest.load_player_inventory()
	yield(inventory_httprequest, "request_completed")
	for i in inventory_httprequest.skins_images_url.size():
		inventory_httprequest.get_image(inventory_httprequest.skins_images_url[i])
		var raw = yield(inventory_httprequest, "request_completed")[3]
		var button = create_inventory_button(raw, inventory_httprequest.skins_scenes_url[i])
		button.connect("pressed", self, "_on_InventorySkinButton_pressed", [button.skin_scene_url])
	
	shop_httprequest.load_skins()
	yield(shop_httprequest, "request_completed")
	for i in shop_httprequest.skins_images_url.size():
		shop_httprequest.get_image(shop_httprequest.skins_images_url[i])
		var raw_image = yield(shop_httprequest, "request_completed")[3]
		var button = create_shop_button(
				raw_image,
				shop_httprequest.skins_scenes_url[i],
				shop_httprequest.skins_ids[i],
				shop_httprequest.skins_playstore_ids[i]
				)
		button.connect("pressed", self, "_on_ShopSkinButton_pressed", [button.asset_id, button.playstore_id])
	NetworkStateLabel.show_skins_loaded()


func create_shop_button(raw_image, scene_url, asset_id, playstore_id):
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load_png_from_buffer(raw_image)
	texture.create_from_image(image)
	var button = skin_button.instance()
	button.texture_normal = texture
	button.skin_scene_url = scene_url
	button.asset_id = asset_id
	button.playstore_id = playstore_id
	shop_container.add_child(button)
	return button


func create_inventory_button(raw_image, scene_url):
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load_png_from_buffer(raw_image)
	texture.create_from_image(image)
	var button = skin_button.instance()
	button.texture_normal = texture
	button.skin_scene_url = scene_url
	inventory_container.add_child(button)
	return button


func _on_InventorySkinButton_pressed(skin_scene_url):
	shop_httprequest.get_skin_scene(skin_scene_url)
	var body = yield(shop_httprequest, "request_completed")[3]
	var file = File.new()
	file.open("user://skin.tscn", File.WRITE_READ)
	file.store_buffer(body)
	file.close()
	Skins.astromouse = load("user://skin.tscn")
	fade_rect.change_scene()


func _on_ShopSkinButton_pressed(skin_id, playstore_id):
	DebugLabel.text = "querying SKU details"
	google_billing.payment.querySkuDetails([playstore_id], "inapp")
	DebugLabel.text = "waiting for query to complete"
	yield(google_billing.payment, "sku_details_query_completed")
	DebugLabel.text = "querying purchase on billing payment"
	google_billing.payment.purchase(playstore_id)
	DebugLabel.text = "waiting for billing to retrieve token"
	yield(google_billing, "purchase_token_retrieved")
	var token = google_billing.token
	DebugLabel.text = "token: %s" % token
	shop_httprequest.purchase(skin_id, token)
