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

export (float) var max_speed = 600
export (float) var  max_force = 0.06
export (float) var arriving_radius = 100
var velocity = Vector2()
var already_pressed = false
onready var target = get_viewport().get_mouse_position()
onready var moon = get_tree().get_nodes_in_group("moon")[0]
func _ready():
	moon.show_gravity()
	acheesements.modify_achievement("starmouse", 1)
	if acheesements.dict["starmouse"].accomplished >= acheesements.dict["starmouse"].total:
		get_node("Sax").play(bgm.get_position())
		get_tree().get_nodes_in_group("crux")[0].get_node("Animator").play("fade")
	if acheesements.dict["mooncheeser"].accomplished >= acheesements.dict["mooncheeser"].total:
		get_node("Sprite").set_texture(load("res://actors/Astromouse/true_starmouse.png"))
		get_node("Sprite/Mask").set_position(Vector2(0,5))
	set_physics_process(true)
	
func _physics_process(delta):
	velocity = steer(target)
	move_and_collide(velocity * delta)
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		target = get_viewport().get_mouse_position()
	elif not Input.is_mouse_button_pressed(BUTTON_LEFT) and already_pressed:
		target = get_position()
	already_pressed = Input.is_mouse_button_pressed(BUTTON_LEFT)

func steer(target_pos):
	var desired_velocity = target_pos - get_position()
	var distance = desired_velocity.length()
	if distance < arriving_radius:
		desired_velocity = desired_velocity.normalized() * max_speed * (distance / arriving_radius)
	else:
		desired_velocity = desired_velocity.normalized() * max_speed
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * max_force)
	return(target_velocity)

func _on_timeout():
	get_node("Sprite/Animator").play("blink")
	
func _on_body_enter( body ):
	if body.is_in_group("cheese"):
		get_node("SFX").emit_signal("is_playing", "pickup")
		body.increase_score()


func _on_animator_finished():
	if acheesements.dict["starmouse"].accomplished >= acheesements.dict["starmouse"].total:
		get_tree().get_nodes_in_group("crux")[0].get_node("Animator").play_backwards("fade")
	if get_parent().get_game_state() == 0:
		moon.hide_gravity()
	else:
		moon.get_node("Tween").set_active(false)
	var i = load("res://actors/Astromouse/Astromouse.tscn").instance()
	i.set_position(get_position())
	get_parent().add_child(i)
	i.get_node("Sprite").set_frame(3)
	queue_free()

