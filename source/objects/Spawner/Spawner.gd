extends Node2D

signal spawned(spawnling_instance)
export (PackedScene) var spawnling

func _ready():
	randomize()


func spawn():
	var instance = spawnling.instance()
	instance.global_position = global_position
	
	get_parent().add_child(instance)
	emit_signal("spawned", instance)
