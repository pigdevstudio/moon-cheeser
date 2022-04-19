extends Control

export(PackedScene) var skin_button

onready var shop_httprequest = $ShopHTTPRequest
onready var inventory_httprequest = $InventoryHTTPRequest
onready var shop_container = $ShopScrollContainer/GridContainer
onready var inventory_container = $InventoryScrollContainer/GridContainer
onready var fade_rect = $FadeRect


func _ready():
	inventory_httprequest.load_player_inventory()
	yield(inventory_httprequest, "request_completed")
	for i in inventory_httprequest.skins_images_url.size():
		inventory_httprequest.get_image(inventory_httprequest.skins_images_url[i])
		var raw = yield(inventory_httprequest, "request_completed")[3]
		var button = create_skin_button(raw, inventory_httprequest.skins_scenes_url[i], inventory_container)
		button.connect("pressed", self, "_on_SkinButton_pressed", [button.skin_scene_url])
	
	shop_httprequest.load_skins()
	yield(shop_httprequest, "request_completed")
	for i in shop_httprequest.skins_images_url.size():
		shop_httprequest.get_image(shop_httprequest.skins_images_url[i])
		var raw = yield(shop_httprequest, "request_completed")[3]
		create_skin_button(raw, shop_httprequest.skins_scenes_url[i], shop_container)


func create_skin_button(raw_image, scene_url, container):
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load_png_from_buffer(raw_image)
	texture.create_from_image(image)
	var button = skin_button.instance()
	button.texture_normal = texture
	button.skin_scene_url = scene_url
	container.add_child(button)
	return button


func _on_SkinButton_pressed(skin_scene_url):
	shop_httprequest.get_skin_scene(skin_scene_url)
	var body = yield(shop_httprequest, "request_completed")[3]
	var file = File.new()
	file.open("user://skin.tscn", File.WRITE_READ)
	file.store_buffer(body)
	file.close()
	Skins.astromouse = load("user://skin.tscn")
	fade_rect.change_scene()
