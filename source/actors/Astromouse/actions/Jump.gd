extends Node

signal executed

export (float) var height = 300.0
export (PackedScene) var strategy

func _ready():
	strategy = strategy.instance()
	add_child(strategy)

func apply(kinematic_actor):
	var direction = strategy.get_direction(kinematic_actor)
	kinematic_actor.velocity = direction * height
	emit_signal("executed")

func reset():
	pass
	
func stop(kinematic_actor):
	kinematic_actor.velocity = Vector2(0, 0)
