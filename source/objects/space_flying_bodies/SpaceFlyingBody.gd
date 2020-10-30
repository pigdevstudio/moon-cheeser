extends "../SpaceKinematicBody.gd"

"""
A flying body that fly towards a given speed at a given direction
"""

onready var _animator = $AnimationPlayer

func _on_DragArea_dragged(_direction):
	$Shape.disabled = false
	$DragArea/Shape.disabled = true
	set_direction(_direction)


func _on_collided(collision):
	_animator.play("explode")
