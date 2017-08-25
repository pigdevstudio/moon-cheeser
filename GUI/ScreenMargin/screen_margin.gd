tool
extends MarginContainer

signal resolution_changed(resolution, manager)
const LOW = Vector2(800, 600)
const MEDIUM = Vector2(1024, 768)
const HIGH = Vector2(1280, 720)
const HD = Vector2(1920, 1080)
export(int, "LOW", "MEDIUM", "HIGH", "HD") var resolution setget set_resolution

onready var winsize = OS.get_window_size()
func _ready():
	edit_set_rect(Rect2(Vector2(), winsize))
	set_process(false)
#	var size = get_rect().size
#	emit_signal("resolution_changed", size, self)
	
func _process(delta):
	
	if not get_tree().is_editor_hint():
		winsize = OS.get_window_size()
	else:
		winsize = get_rect().size
	if get_rect().size != winsize:
		var size = get_rect().size
		edit_set_rect(Rect2(Vector2(), winsize))
		emit_signal("resolution_changed", size, self)

func set_resolution(value):
	resolution = value
	if value == 0:
		emit_signal("resolution_changed", LOW, self)
		edit_set_rect(Rect2(Vector2(),LOW))
	elif value == 1:
		emit_signal("resolution_changed", MEDIUM, self)
		edit_set_rect(Rect2(Vector2(),MEDIUM))
	elif value == 2:
		emit_signal("resolution_changed", HIGH, self)
		edit_set_rect(Rect2(Vector2(),HIGH))
	elif value == 3:
		emit_signal("resolution_changed", HD, self)
		edit_set_rect(Rect2(Vector2(),HD))
		