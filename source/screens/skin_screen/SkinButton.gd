extends TextureButton

signal skin_selected(new_skin, type)

export (PackedScene) var new_skin
export (String) var type


func _pressed():
	emit_signal("skin_selected", new_skin, type)
