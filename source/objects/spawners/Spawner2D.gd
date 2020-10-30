extends Position2D

signal spawned(spawn)

export(PackedScene) var spawn_scene

func spawn():
	var spawn = spawn_scene.instance()
	add_child(spawn)
	spawn.set_as_toplevel(true)
	spawn.global_position = global_position
	emit_signal("spawned", spawn)
	return spawn
