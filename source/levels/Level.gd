extends Node

signal game_over

onready var astromouse = $Astromouse
onready var moon = $Moon

func _ready():
	randomize()


func _physics_process(delta):
	if astromouse.is_on_floor():
		return
	var mouse_to_moon_direction = astromouse.global_position.direction_to(moon.global_position)
	astromouse.velocity += mouse_to_moon_direction * (moon.gravity_strength * delta)


func _on_JumpArea2D_input_event(viewport, event, shape_idx):
	if not event.is_action("click"):
		return
	if event.is_pressed():
		astromouse.jump.execute()
	else:
		astromouse.jump.cancel()
