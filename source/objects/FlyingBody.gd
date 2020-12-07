extends KinematicBody2D

signal collided(collision)

export var direction = Vector2.RIGHT setget set_direction
export (float) var speed = 300.0

var _collision

onready var velocity = direction * speed
onready var _animator = $AnimationPlayer
onready var _sprite_animator = $Sprite/AnimationPlayer


func _physics_process(delta):
	_collision = move_and_collide(velocity * delta)
	if _collision:
		set_physics_process(false)
		_animator.play("explode")
		emit_signal("collided", _collision)


func stop():
	_sprite_animator.stop()
	velocity = Vector2(0, 0)


func set_direction(new_direction):
	_sprite_animator.play()
	direction = new_direction
	velocity = direction * speed
