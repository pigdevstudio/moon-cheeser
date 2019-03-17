extends "res://objects/SpaceKinematicBody.gd"

"""
A flying body that fly towards a given speed at a given direction
"""

export (float) var flying_speed = 300.0

func _on_collided(collision):
	var collider = collision.collider
	if collider.has_method("spawn_cheeses"):
		collider.spawn_cheeses(collision.position)
	if collider.has_method("spawn_crater"):
		collider.spawn_crater(collision)
	queue_free()

func _on_DragArea_dragged(direction):
	$Shape.disabled = false
	$DragArea/Shape.disabled = true

func fly(direction):
	if direction.length() > 0:
		velocity = flying_speed * direction
		rotation = direction.angle()

func spawn_cheeses(spawn_position):
	var spawner = get_node("CheeseSpawner").duplicate()
	get_parent().add_child(spawner)
	spawner.position = spawn_position
	spawner.spawn()
	queue_free()

func queue_free():
	$Shape.disabled = true
	hide()
	$CollidingSFX.play()
	yield($CollidingSFX, "finished")
	.queue_free()
