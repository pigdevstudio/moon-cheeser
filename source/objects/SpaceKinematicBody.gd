extends KinematicBody2D

signal collided(collision)

var velocity = Vector2(0, 0)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = Vector2(0, 0)
		emit_signal("collided", collision)
		
func stop():
	velocity = Vector2(0, 0)
