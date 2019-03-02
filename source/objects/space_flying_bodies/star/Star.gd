extends "res://objects/space_flying_bodies/SpaceFlyingBody.gd"

func spawn_starmouse():
	var spawner = get_node("StarmouseSpawner").duplicate()
	spawner.global_position = global_position
	get_parent().add_child(spawner)
	spawner.call_deferred("spawn")
	spawner.queue_free()

func _on_StarmousePickupArea_body_entered(body):
	if body.is_in_group("player"):
		spawn_starmouse()
		queue_free()
