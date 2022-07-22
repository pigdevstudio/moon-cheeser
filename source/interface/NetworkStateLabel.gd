extends CanvasLayer


export(String, MULTILINE) var text setget set_text

onready var _label = $Label
onready var _color_rect = $ColorRect
onready var _animation_player = $AnimationPlayer


func _ready():
	set_process_input(false)


func _input(event):
	get_tree().set_input_as_handled()


func set_text(new_text):
	text = new_text
	if not _label:
		yield(self, "ready")
	_label.text = text


func show():
	set_process_input(true)
	_label.show()
	_color_rect.show()


func hide():
	set_process_input(false)
	_label.hide()
	_color_rect.hide()


func show_authentication():
	_animation_player.play("authenticating")


func show_authentication_failed():
	_animation_player.play("auth_failed")


func show_login_successful():
	_animation_player.play("login_success")


func show_loading_skins():
	_animation_player.play("loading_skins")


func show_skins_loaded():
	_animation_player.play("skins_loaded")


func show_purchasing():
	_animation_player.play("purchasing")


func show_purchased():
	_animation_player.play("purchased")


func show_loading_board():
	_animation_player.play("loading_leaderboard")


func show_board_loaded():
	_animation_player.play("leaderboard_loaded")
