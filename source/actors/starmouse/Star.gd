extends Sprite


func swap_skin():
	for child in get_children():
		child.queue_free()
	replace_by(Skins.starmouse.instance())
