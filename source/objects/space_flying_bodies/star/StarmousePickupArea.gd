extends Area2D

signal player_entered

func spawn_starmouse():
	var spawner = $StarmouseSpawner.duplicate()
	spawner.global_position = global_position
	var level = find_parent("Level")
	level.add_child(spawner)
	spawner.call_deferred("spawn")
	spawner.queue_free()

func _on_body_entered(body):
	if body.is_in_group("player"):
		spawn_starmouse()
		emit_signal("player_entered")
