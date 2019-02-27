extends "res://objects/GravityBody.gd"

func _on_Singularity_body_entered(body):
	if body.is_in_group("player"):
		body.queue_free()
