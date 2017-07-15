extends KinematicBody2D

var direction = 1
var is_mouse_on = false
var already_pressed = false

onready var fixed_process = set_fixed_process(true)
onready var velocity = Vector2()

func _exit_screen():
	queue_free()

func _ready():
	velocity = Vector2(direction,0) * 300

func _fixed_process(delta):
	if Input.is_mouse_button_pressed(1) and not already_pressed and is_mouse_on:
		var n = (get_global_mouse_pos() - get_global_pos()).normalized() * Vector2(1, -1)
		velocity = n.slide(velocity) * 5
		velocity = Vector2(300 * direction,velocity.y)
		already_pressed = true
	var motion = move(velocity * delta)
	if is_colliding():
		if get_collider().is_in_group("moon"):
			var crater = load("res://Objects/Crater/Crater.tscn").instance()
			get_collider().get_node("Sprite").add_child(crater)
			crater.set_global_pos(get_collision_pos())
			crater.set_rot(crater.get_angle_to(get_collider().get_pos()))
			
			var c = load("res://Objects/Cheese/Cheese.tscn").instance()
			get_collider().get_node("Sprite").add_child(c)
			c.set_pos(get_collision_pos())
			
			queue_free()
func _set_mouse_on(is_on):
	is_mouse_on = is_on
