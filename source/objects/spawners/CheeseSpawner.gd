extends "Spawner2D.gd"

"""
Spread a random amount of cheeses 
"""

export (int) var min_cheeses = 2
export (int) var max_cheeses = 8

export (float) var spread = 10 setget set_spread
export (float) var min_radius = 50
export (float) var max_radius = 200

export var trans_curve = Tween.TRANS_BACK
export var ease_type = Tween.EASE_OUT
export var tween_duration = 0.5

onready var _tween = $Tween


func spawn():
	var cheeses = randi()%max_cheeses + min_cheeses
	cheeses = min(cheeses, min_cheeses)
	
	var cheese
	for i in cheeses:
		cheese = spawn_scene.instance()
		add_child(cheese)
		cheese.global_position = global_position
		cheese.connect("tree_exited", self, "_on_Cheese_tree_exited")
		surge(cheese)
	_tween.start()
	return cheese


func surge(cheese):
	var _distance  = rand_range(min_radius, max_radius)
	var _spread = deg2rad(rand_range(-spread, spread))
	var offset = _distance * Vector2(0, -1).rotated(_spread)
	_tween.interpolate_property(cheese, "position", cheese.position, 
			cheese.position + offset, tween_duration, trans_curve, ease_type)


func set_spread(value):
	spread = clamp(value, 0, 180)


func _on_Cheese_tree_exited():
	if get_child_count() < 1:
		queue_free()
