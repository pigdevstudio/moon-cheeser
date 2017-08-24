extends KinematicBody2D

const MAX_SPEED = 300

export var direction = 1
var is_mouse_on = false setget _set_mouse_on
var already_pressed = false
var route_already_changed = false
var already_slide = false
var is_sliding = false
onready var initial_pos = get_pos()
var current_pos = Vector2(0,0)
onready var moon = get_tree().get_nodes_in_group("moon")[0]
onready var fixed_process = set_fixed_process(true)
onready var velocity = Vector2()

func _ready():
	get_node("Sprite").set_scale(get_node("Sprite").get_scale() * -direction)
	get_node("Sprite").set_pos(Vector2(0, 0))
	velocity = Vector2(direction,0) * MAX_SPEED

func _fixed_process(delta):
	if is_colliding():
		_handle_collision(get_collider())
	move(apply_route() * delta)
	already_pressed = Input.is_mouse_button_pressed(BUTTON_LEFT)

func _set_mouse_on(is_on):
	moon.is_mouse_on = !is_on
	is_mouse_on = is_on
	
func _exit_screen():
	queue_free()

func apply_route():
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and not already_pressed and is_mouse_on:
		initial_pos = get_global_mouse_pos()
		route_already_changed = true
		is_sliding = true
		get_node("Animator").stop(true)

	elif not Input.is_mouse_button_pressed(BUTTON_LEFT) and already_pressed:
		if not already_slide and is_sliding:
			_slide()
			get_node("Animator").seek(0.5, true)
	return(velocity)

func _spawn_crater(position):
		if get_parent().get_game_state() == 0:
			var instance = load("res://Objects/Crater/Crater.tscn").instance()
			get_collider().get_node("Sprite").add_child(instance)
			instance.set_global_pos(position)
			instance.set_rot(instance.get_angle_to(get_collider().get_pos()))
			
			instance = load("res://Objects/Crater/CraterPlaceholder.tscn").instance()
			get_collider().get_node("Sprite").add_child(instance)
			instance.set_global_pos(position)
			instance.set_rot(instance.get_angle_to(get_collider().get_pos()))
			
			instance = load("res://Actors/SFX.tscn").instance()
			get_collider().get_node("Sprite").add_child(instance)

func _handle_collision(collider):
	if collider != null:
		if collider.is_in_group("moon"):
			if self.is_in_group("comet") and route_already_changed:
				acheesements.modify_achievement("firststep", 1)
			_spawn_crater(get_collision_pos())
		elif collider.is_in_group("player"):
			if has_method("_instance_starmouse"):
				_instance_starmouse(collider)
			elif has_method("_kill_player"):
				_kill_player(collider)
				
		elif collider.is_in_group("star") and self.is_in_group("star"):
			collider.queue_free()
			if route_already_changed:
				acheesements.modify_achievement("supernova", 1)
		
		if not collider.is_in_group("cheese"):
			queue_free()

func _slide():
	current_pos = get_global_mouse_pos()
	var normal =  -1 * sign(initial_pos.y - current_pos.y)
	velocity = Vector2(MAX_SPEED * direction,  normal * MAX_SPEED * 2)
	var point = get_pos() + (Vector2(-velocity.normalized().x, velocity.normalized().y) * (100 * normal))
	rotate(get_angle_to(point))
	var angle = get_angle_to(get_pos() - velocity)
	get_node("Sprite/Outer").set_param(Particles2D.PARAM_INITIAL_ANGLE, rad2deg(angle) + 90)
	if is_in_group("comet"):
		get_node("Sprite/Inner").set_param(Particles2D.PARAM_INITIAL_ANGLE, rad2deg(angle) + 90)
	already_slide = true