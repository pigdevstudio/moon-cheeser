extends "res://objects/space_flying_bodies/FlyingBody.gd"

func _on_collided(collision):
	var collider = collision.collider
	if collider.has_method("spawn_cheeses"):
		collider.spawn_cheeses(collision)
	queue_free()


func _on_DragArea_dragged(direction):
	$Shape.disabled = false
	$DragArea/Shape.disabled = true


func spawn_cheeses(collision):
	var spawner = get_node("CheeseSpawner").duplicate()
	get_parent().add_child(spawner)
	spawner.position = collision.position
	spawner.spawn()

