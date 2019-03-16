extends Area2D

signal body_killed

func _on_body_entered(body):
	if body.has_method("die"):
		body.die()
		emit_signal("body_killed")
