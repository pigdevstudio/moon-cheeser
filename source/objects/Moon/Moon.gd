extends StaticBody2D

const MAX_PULL = 0.7

export var gravity_strength = 400.0
export var pull_strength = 0.1

var astromouse

onready var _pivot = $Sprite
onready var _tween = $Tween
onready var _cheese_spawner = $CheeseSpawner
onready var _crater_spawner = $Sprite/CraterSpawner


func _ready():
	set_process_input(false)
	set_physics_process(false)
	_tween.sprite = $Sprite/GravityField


func _physics_process(delta):
	if not astromouse:
		return
	var velocity = global_position.direction_to(astromouse.global_position) * gravity_strength
	velocity *= -pull_strength
	astromouse.move_and_collide(velocity * delta)
	pull_strength -= 0.5 * delta
	pull_strength = max(0.0, pull_strength)


func _input(event):
	if event.is_action_pressed("jump"):
		pull()


func pull():
	_tween.pulse()
	pull_strength += 0.5
	pull_strength = min(pull_strength, MAX_PULL)


func spawn_crater(collision):
	var crater = _crater_spawner.spawn()
	crater.set_as_toplevel(false)
	crater.global_position = collision.position
	crater.rotation = collision.normal.angle() - _pivot.rotation
	crater.rotation_degrees += 90
	
	var cheese_spawner = _cheese_spawner.duplicate()
	_pivot.add_child(cheese_spawner)
	cheese_spawner.global_position = collision.position
	cheese_spawner.rotation = crater.rotation
	cheese_spawner.spawn()
