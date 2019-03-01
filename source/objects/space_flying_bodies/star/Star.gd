extends "res://objects/space_flying_bodies/SpaceFlyingBody.gd"

func _on_collided(collision):
	if collision.collider.is_in_group("player"):
		spawn_starmouse(collision)
		collision.collider.queue_free()
		queue_free()
	else:
		._on_collided(collision)


func spawn_starmouse(collision):
	var spawner = get_node("StarmouseSpawner").duplicate()
	get_parent().add_child(spawner)
	spawner.global_position = collision.position
	spawner.spawn()
	spawner.queue_free()
