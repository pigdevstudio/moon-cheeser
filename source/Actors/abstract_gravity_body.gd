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
extends Node2D

export (float) var gravity_strength = 200
const MAX_GRAVITY = 600

func _apply_gravity(target):
	if target != null:
		get_tree().get_nodes_in_group("player")[0].set_gravity_scale(1)
		var direction = (get_pos() - target.get_pos()).normalized()
		target.apply_impulse(Vector2(0, 0), gravity_strength * direction)
		if is_in_group("moon"):
			target.set_angular_velocity(-target.get_angle_to(get_pos()))
		else:
			target.set_angular_velocity(target.get_angle_to(get_pos()))
func _find_player():
	var player = null
	if get_tree().get_nodes_in_group("player").size() > 0:
		player = get_tree().get_nodes_in_group("player")[0]
		if player extends RigidBody2D:
			return(player)
		else:
			return(null)