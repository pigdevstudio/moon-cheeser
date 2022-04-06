extends ShadedButton

export (PackedScene) var new_skin
export (String) var type


func _pressed():
	Skins.set(type, new_skin)

