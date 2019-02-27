extends Area2D

signal scored(amount)

export (int) var score = 100

func surge(offset_distance):
	var t = $Tween
	var offset = offset_distance * Vector2(0, -1).rotated(rotation)
	
	t.interpolate_property(self, "position", position, position + offset, 0.5,
			t.TRANS_BACK, t.EASE_OUT)
	t.start()


func _on_area_entered(body):
	if body.is_in_group("player"):
		emit_signal("scored", score)
		queue_free()

