extends "res://objects/Comet/FlyingBody.gd"

func _on_collided(collision):
	var collider = collision.collider
	
	if collider.has_method("spawn_cheeses"):
		collider.spawn_cheeses(collision)
		queue_free()


func _on_DragArea_dragged(direction):
	$DragArea/Shape.disabled = true
