extends Node2D

onready var particles = $Sprites/Particles
onready var character = $Sprites/AstromouseCharacter

export (float) var speed = 300.0
var _direction = Vector2(0, 0)
var _velocity = Vector2(0, 0)

func _ready():
	character.play("grab_star")

func _physics_process(delta):
	_velocity += $SteeringSeek.steer(_velocity, _direction * speed)
	translate(_velocity * delta)
	particles.rotation = -_velocity.angle()
	particles.emitting = _velocity.length() > 100

func seek(target_pos):
	_direction = (target_pos - global_position).normalized()

func stop():
	_direction = Vector2(0, 0)
