extends ScrollContainer

signal skin_selected

export(PackedScene) var skin_button

onready var grid = $GridContainer
onready var http_request = $HTTPRequest


func load_skins():
	var url = "https://api.lootlocker.io/game/v1/player/inventory/list"
	var header = ["Content-Type: application/json", "x-session-token: %s" % LootLocker.token]
	var method = HTTPClient.METHOD_GET
	http_request.request(url, header, false, method)
	
	var response = yield(http_request, "request_completed")[3]
	response = JSON.parse(response.get_string_from_utf8()).result
	
	for asset in response['inventory']:
		var scene_url = asset['asset']['files'][0]['url']
		var image_url = asset['asset']['files'][1]['url']
		var id = asset['asset']['id']
		create_skin_button(scene_url, image_url)


func create_skin_button(scene_url, image_url):
	var button = skin_button.instance()
	button.skin_image_url = image_url
	button.skin_scene_url = scene_url
	grid.add_child(button)
	button.connect("pressed", self, "_on_SkinButton_pressed", [button.skin_scene_url])


func _on_SkinButton_pressed(skin_scene_url):
	http_request.request(skin_scene_url, [skin_scene_url])
	
	var body = yield(http_request, "request_completed")[3]
	
	var file = File.new()
	if file.file_exists("user://skin.tscn"):
		var directory = Directory.new()
		directory.remove("user://skin.tscn")
	
	file.open("user://skin.tscn", File.WRITE)
	file.store_buffer(body)
	file.close()
	
	Skins.astromouse = null
	Skins.astromouse = load("user://skin.tscn")
	emit_signal("skin_selected")
