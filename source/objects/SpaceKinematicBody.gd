extends KinematicBody2D

signal collided(collision)

export var direction = Vector2.RIGHT setget set_direction
export (float) var speed = 300.0

onready var velocity = direction * speed

var _collision

func _physics_process(delta):
	_collision = move_and_collide(velocity * delta)
	if _collision:
		stop()
		emit_signal("collided", _collision)


func stop():
	velocity = Vector2(0, 0)


func set_direction(new_direction):
	direction = new_direction
	velocity = direction * speed
	if direction.length() > 0.0:
		rotation = direction.angle()
