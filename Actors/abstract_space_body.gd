#MIT License
#
#Copyright (c) 2017 Pigdev Studio
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.
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

func apply_route():
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and not already_pressed and is_mouse_on:
		initial_pos = get_global_mouse_pos()
		route_already_changed = true
		is_sliding = true

	elif not Input.is_mouse_button_pressed(BUTTON_LEFT) and already_pressed:
		moon.is_mouse_on = true
		if not already_slide and is_sliding:
			current_pos = get_global_mouse_pos()
			slide( -1 * sign((initial_pos - current_pos).y))
	return(velocity)

func _spawn_crater(position):
		if get_parent().get_game_state() == 0:
			var instance = load("res://Objects/Crater/Crater.tscn").instance()
			get_collider().get_node("Sprite").add_child(instance)
			instance.set_global_pos(position)
			instance.set_rot(instance.get_angle_to(get_collider().get_pos()))
			spawn_placeholder(0, position)

func _handle_collision(collider):
	if collider != null:
		if collider.is_in_group("moon"):
			if self.is_in_group("comet") and route_already_changed:
				acheesements.modify_achievement("firststep", 1)
			_spawn_crater(get_collision_pos())
			queue_free()
		elif collider.is_in_group("player"):
			if has_method("_instance_starmouse"):
				_instance_starmouse(collider)
			elif has_method("_kill_player"):
				_kill_player(collider)
			queue_free()
		elif collider.is_in_group("star") and self.is_in_group("star"):
			acheesements.modify_achievement("supernova", 1)
			collider.free()
			spawn_placeholder(3, get_collision_pos())
			queue_free()
		elif collider.is_in_group("space_body"):
			var collgroup = collider.is_in_group("comet")
			collider.free()
			if self.is_in_group("comet") and collgroup:
				spawn_placeholder(2, get_collision_pos())
			else:
				spawn_placeholder(1, get_collision_pos())
			queue_free()
			
		elif not collider.is_in_group("cheese"):
			queue_free()

func slide(normal):
	velocity = Vector2(MAX_SPEED * direction,  normal * MAX_SPEED * 2)
	var point = get_pos() + (Vector2(-velocity.normalized().x, velocity.normalized().y) * (100 * normal))
	rotate(get_angle_to(point))
	var angle = get_angle_to(get_pos() - velocity)
	get_node("Sprite/Tail").set_param(Particles2D.PARAM_INITIAL_ANGLE, rad2deg(angle) + 90)
	if is_in_group("comet"):
		get_node("Sprite/Core").set_param(Particles2D.PARAM_INITIAL_ANGLE, rad2deg(angle) + 90)
	already_slide = true
	
func spawn_placeholder(type, position):
	var instance
	if type == 0:
		instance = load("res://Objects/Crater/CraterPlaceholder.tscn").instance()
		get_collider().get_node("Sprite").add_child(instance)
		instance.set_global_pos(position)
		instance.set_rot(instance.get_angle_to(get_collider().get_pos()))
		instance.spawn_cheeses(type)
		instance = load("res://Actors/SFX.tscn").instance()
		get_collider().get_node("Sprite").add_child(instance)
	elif type == 1:
		instance = load("res://Objects/Crater/CraterPlaceholder.tscn").instance()
		get_parent().add_child(instance)
		instance.set_global_pos(position)
		instance.set_scale(moon.get_node("Sprite").get_scale())
		instance.spawn_cheeses(type)
		instance = load("res://Actors/SFX.tscn").instance()
		get_parent().add_child(instance)
	elif type == 2:
		instance = load("res://Objects/Crater/CraterPlaceholder.tscn").instance()
		instance.set_global_pos(position)
		instance.set_scale(moon.get_node("Sprite").get_scale())
		get_parent().add_child(instance)
		instance.spawn_cheeses(type)
		instance = load("res://Actors/SFX.tscn").instance()
		get_parent().add_child(instance)
	elif type == 3:
		instance = load("res://Actors/Star/super_nova.tscn").instance()
		instance.set_global_pos(position)
		get_parent().add_child(instance)
		instance = load("res://Actors/SFX.tscn").instance()
		get_parent().add_child(instance)
