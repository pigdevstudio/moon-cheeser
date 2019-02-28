extends Node2D

onready var tween = $Tween
onready var timer = $Duration

func _ready():
#	if get_tree().get_nodes_in_group("crater").size() >= 5:
#		acheesements.modify_achievement("madness", 1)
	get_node("Particles").set_emitting(true)
	tween.interpolate_property($Sprite, "scale", Vector2(0, 0), $Sprite.scale, 
	0.25, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
	$Area2D/CollisionPolygon2D.disabled = false
	timer.set_wait_time(rand_range(4,12))
	timer.start()

func _on_timeout():
	$Area2D/CollisionPolygon2D.disabled = true
	tween.interpolate_property($Sprite, "scale", $Sprite.scale, Vector2(0, 0), 
	0.25, Tween.TRANS_BACK, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	queue_free()


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		print("player")
