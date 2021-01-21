extends Area2D
"""
Main source of scoring
"""
signal scored(amount)

export (int) var score = 100

onready var _animator = $Animator


func _ready():
	connect("scored", Score, "add_score")
	_animator.play("pulsing")


func _on_area_entered(area):
	emit_signal("scored", score)
	_animator.play("picked")
