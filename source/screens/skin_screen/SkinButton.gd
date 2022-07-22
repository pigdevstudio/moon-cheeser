extends ShadedButton

export var skin_image_url = ""
export var skin_scene_url = ""
export var asset_id = ""
export var playstore_id = ""

onready var http_request = $HTTPRequest

func _ready():
	http_request.request(skin_image_url)
	var raw_image = yield(http_request, "request_completed")[3]
	var skin_texture = ImageTexture.new()
	var image = Image.new()
	image.load_png_from_buffer(raw_image)
	skin_texture.create_from_image(image)
	texture_normal = skin_texture
