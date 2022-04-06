extends Control

onready var skin_httprequest = $SkinHTTPRequest


func _ready():
	skin_httprequest.get_skins()
