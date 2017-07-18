extends TextureButton
export (NodePath) var slider_path
onready var slider = get_node(slider_path)
func _ready():
	slider.set_value(bgm.get_volume())
	
func _input_event(event):
	if Input.is_key_pressed(KEY_VOLUMEUP):
		print("increase volume")
		slider.set_value(slider.get_volume() + 4)
	if Input.is_key_pressed(KEY_VOLUMEDOWN):
		slider.set_value(slider.get_volume() - 4)

func _on_Slider_value_changed( value ):
	bgm.set_volume(value)
	if value <= 0:
		bgm.set_paused(true)
		set_normal_texture(load("res://Screens/Title_Screen/sound_mute.png"))
		slider.set_value(0)
	else:
		bgm.set_paused(false)
		set_normal_texture(load("res://Screens/Title_Screen/sound_icon.png"))

func _on_Sound_released():
	if bgm.is_paused():
		bgm.set_paused(false)
		set_normal_texture(load("res://Screens/Title_Screen/sound_icon.png"))
		slider.set_value(8)
	else:
		bgm.set_paused(true)
		set_normal_texture(load("res://Screens/Title_Screen/sound_mute.png"))
		slider.set_value(0)

