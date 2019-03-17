extends Node

signal executed

export (float) var height = 300.0
export (PackedScene) var strategy

func _ready():
	strategy = strategy.instance()
	add_child(strategy)

func apply(space_space_kinematic_body):
	var direction = strategy.get_direction(space_space_kinematic_body)
	space_space_kinematic_body.velocity = direction * height
	emit_signal("executed")

func reset():
	pass
	
func stop(space_space_kinematic_body):
	space_space_kinematic_body.velocity = Vector2(0, 0)
