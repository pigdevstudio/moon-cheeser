extends Node
class_name ActionResource

signal max_changed(new_max)
signal changed(new_amount)
signal depleted


export var max_amount = 10 setget set_max
var current = max_amount setget set_current

var depleted := false

func _ready() :
	initialize()


func set_max(new_max: float) :
	max_amount = new_max
	max_amount = max(1, new_max)
	emit_signal("max_changed", max_amount)


func set_current(new_value: float) :
	if current == new_value:
		return
	current = new_value
	current = clamp(current, 0.0, max_amount)
	emit_signal("changed", current)

	if current == 0.0:
		depleted = true
		emit_signal("depleted")


func initialize() :
	current = max_amount
	emit_signal("max_changed", max_amount)
	emit_signal("changed", current)
