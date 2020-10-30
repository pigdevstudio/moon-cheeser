extends Node2D

onready var _animator = $Animator

func _on_RandomTimer_timeout():
	_animator.play("disappear")
