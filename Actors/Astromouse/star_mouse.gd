extends KinematicBody2D

export (float) var max_speed = 600
export (float) var  max_force = 0.06
export (float) var slowing_radius = 100
var velocity = Vector2()
onready var target = get_pos()
onready var particles = get_node("Particles")
func _ready():
	get_node("Sprite").set_texture(load(skins.starmouse_skin))
	set_fixed_process(true)
	
func _fixed_process(delta):
	velocity = steer(target)
	move(velocity * delta)
	var angle = get_angle_to(get_pos() - velocity)
	if Input.is_mouse_button_pressed(1):
		target = get_viewport().get_mouse_pos()
#		particles.set_param(particles.PARAM_INITIAL_ANGLE, rad2deg(angle) + 90)
#		particles.set_rot(angle)
#	else:
#		particles.set_param(particles.PARAM_INITIAL_ANGLE, 90)
#		particles.set_rot(0)
		
func steer(target_pos):
	var desired_velocity = target_pos - get_pos()
	var distance = desired_velocity.length()
	if distance < slowing_radius:
		desired_velocity = desired_velocity.normalized() * max_speed * (distance / slowing_radius)
	else:
		desired_velocity = desired_velocity.normalized() * max_speed
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * max_force)
	return(target_velocity)

func _on_timeout():
	var i = load("res://Actors/Astromouse/Astromouse.tscn").instance()
	i.set_pos(get_pos())
	get_parent().add_child(i)
	i.get_child(0).play("jumping")
	queue_free()

func _on_body_enter( body ):
	if body.is_in_group("cheese"):
		print("score +1")
		body.queue_free()
