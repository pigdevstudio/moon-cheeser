extends Area2D
"""
Main source of scoring
"""
signal scored(amount)

export (int) var score = 100

func _on_area_entered(area):
	emit_signal("scored", score)
	hide()
	$Shape.call_deferred("set_disabled", true)
	$PickupSound.play()
	yield($PickupSound, "finished")
	queue_free()
