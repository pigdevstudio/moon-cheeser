extends Position2D


func play(animation):
	if not $animator.current_animation == animation:
		$animator.play(animation)


func swap_skin():
	for child in get_children():
		child.queue_free()
	replace_by(Skins.astromouse.instance())
