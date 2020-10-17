extends KinematicBody2D

signal collided(collision)

var velocity = Vector2(0, 0)

var _collision

func _physics_process(delta):
	_collision = move_and_collide(velocity * delta)
	if _collision:
		stop()
		emit_signal("collided", _collision)


func stop():
	velocity = Vector2(0, 0)
