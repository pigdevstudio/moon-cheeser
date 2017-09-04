extends KinematicBody2D

export (float) var max_speed = 600
export (float) var  max_force = 0.06
export (float) var slowing_radius = 100
var velocity = Vector2()
var already_pressed = false
onready var target = get_viewport().get_mouse_pos()
onready var moon = get_tree().get_nodes_in_group("moon")[0]
func _ready():
	moon.show_gravity()
	acheesements.modify_achievement("starmouse", 1)
	get_node("Sprite").set_texture(load(skins.starmouse_skin))
	set_fixed_process(true)
	
func _fixed_process(delta):
	velocity = steer(target)
	move(velocity * delta)
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		target = get_viewport().get_mouse_pos()
	elif not Input.is_mouse_button_pressed(BUTTON_LEFT) and already_pressed:
		target = get_pos()
	already_pressed = Input.is_mouse_button_pressed(BUTTON_LEFT)

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
	get_node("Sprite/Animator").play("blink")

func _on_body_enter( body ):
	if body.is_in_group("cheese"):
		body.increase_score()


func _on_animator_finished():
	if get_parent().get_game_state() == 0:
		moon.hide_gravity()
	var i = load("res://Actors/Astromouse/Astromouse.tscn").instance()
	i.set_pos(get_pos())
	get_parent().add_child(i)
	i.get_node("Sprite").set_frame(3)
	queue_free()
