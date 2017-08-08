extends StaticBody2D

onready var tween = get_node("Tween")
onready var timer = get_node("Timer")

func _ready():
	get_node("Particles").set_emitting(true)
	tween.interpolate_property(self, "transform/scale", Vector2(0, 0), get_scale(), 
	0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_complete")
	timer.set_wait_time(rand_range(4,12))
	timer.start()

func _on_timeout():
	tween.interpolate_property(self, "transform/scale", get_scale(), Vector2(0, 0), 
	0.5, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_complete")
	queue_free()