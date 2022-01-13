extends Node2D

signal finished

export var speed = 300.0
export var mass = 20.0
export var duration = 5.0

var _direction = Vector2(0, 0)
var _velocity = Vector2(0, 0)

onready var character = $Sprites/SwingPivot/AstromouseCharacter
onready var pivot = $Sprites/SwingPivot
onready var animator = $AnimationPlayer
onready var timer = $Duration


func _ready():
	character.play("grab_star")
	timer.start(duration)


func _physics_process(delta):
	move()
	if _direction:
		pivot.swing()


func move():
	var delta = get_physics_process_delta_time()
	steer()
	pivot.movement_velocity = _velocity
	
	translate(_velocity * delta)


func seek(target_pos):
	_direction = (target_pos - global_position).normalized()


func stop():
	pivot.rest()
	_direction = Vector2(0, 0)


func steer():
	var steering =  (_direction * speed) - _velocity
	steering /= mass
	_velocity += steering


func _on_Duration_timeout() -> void:
	animator.play("Disappear")
