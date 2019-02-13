extends Area2D

func surge():
	var t = $Tween
	var offset = rand_range(50, 200) * Vector2(0, -1).rotated(rotation)
	
	t.interpolate_property(self, "position", position, position + offset, 0.5,
			t.TRANS_BACK, t.EASE_OUT)
	t.start()

