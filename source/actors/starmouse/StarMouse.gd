extends Node2D

onready var particles = $Sprites/Particles
onready var character = $Sprites/Pivot/AstromouseCharacter
onready var pivot = $Sprites/Pivot

export (float) var speed = 300.0
var _direction = Vector2(0, 0)
var _velocity = Vector2(0, 0)

func _ready():
	character.play("grab_star")

func _physics_process(delta):
	_velocity += $SteeringSeek.steer(_velocity, _direction * speed)
	translate(_velocity * delta)
	particles.rotation = -_direction.angle()
	particles.emitting = _velocity.length() > 100
	
	var direction_angle = _velocity.angle() + (PI * 0.5)
	if _direction.length() <= 0:
		pivot.rotation = lerp(pivot.rotation, 0.0, 0.05)
	else:
		pivot.rotation = direction_angle
	
	if direction_angle > 0 and direction_angle < 2.5:
		pivot.scale.x = 1
	else:
		pivot.scale.x = -1

func seek(target_pos):
	_direction = (target_pos - global_position).normalized()

func stop():
	_direction = Vector2(0, 0)
