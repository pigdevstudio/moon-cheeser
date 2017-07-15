extends KinematicBody2D

export (float) var max_speed = 600
export (float) var  max_force = 0.02
var velocity = Vector2()
onready var target = get_pos()

export (int, "SEEK", "FLEE") var mode = 0
func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	velocity = steer(target)
	move(velocity * delta)
	if Input.is_mouse_button_pressed(1):
		target = get_viewport().get_mouse_pos()
func steer(target):
	var desired_velocity = Vector2(target - get_pos()).normalized() \
	* max_speed
	if mode == 0:
		pass
	elif mode == 1:
		desired_velocity = -desired_velocity
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * max_force)
	return(target_velocity)

func _on_timeout():
	var i = load("res://Actors/Astromouse/AstromouseRigid.tscn").instance()
	i.set_pos(get_pos())
	get_parent().add_child(i)
	queue_free()
