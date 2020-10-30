extends Tween

var sprite


func pulse():
	if is_active():
		return
	interpolate_property(sprite, "scale", sprite.scale, 
			sprite.scale + Vector2(0.25, 0.25), 0.5, TRANS_BACK, EASE_OUT)
	start()
	yield(self, "tween_completed")

	interpolate_property(sprite, "scale", sprite.scale,
			sprite.scale - Vector2(0.25, 0.25), 0.5, TRANS_BACK, EASE_OUT)
	start()
