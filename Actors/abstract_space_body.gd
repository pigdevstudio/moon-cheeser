extends KinematicBody2D

var direction = 1
var is_mouse_on = false
var already_pressed = false
const MAX_SPEED = 300
onready var fixed_process = set_fixed_process(true)
onready var velocity = Vector2()


func apply_route():
	if Input.is_mouse_button_pressed(1) and not already_pressed and is_mouse_on:
		var n = get_global_pos().rotated(get_global_pos().angle_to_point(get_global_mouse_pos())).normalized()
		velocity = n.slide(velocity)
		already_pressed = true
		velocity = Vector2(MAX_SPEED * direction,velocity.y)
	return(velocity)

func _ready():
	velocity = Vector2(direction,0) * MAX_SPEED

func _fixed_process(delta):
	move(apply_route() * delta)

func _set_mouse_on(is_on):
	is_mouse_on = is_on
	
func _exit_tree():
	queue_free()