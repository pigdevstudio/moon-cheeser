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
extends Position2D

export (PackedScene) var spawn_scene
export (float) var min_spawn_time = 1.0
export (float) var max_spawn_time = 2.0

func _ready():
	randomize()
	get_node("Timer").set_wait_time(floor(rand_range(min_spawn_time, max_spawn_time)))
	if acheesements.already_played == true:
		get_node("Timer").set_autostart(false)
		get_node("Timer").start()
func _spawn():
	if get_parent().has_method("set_game_state"):
		if get_parent().game_state == 0:
			var spawn = spawn_scene.instance()
			spawn.set_transform(get_transform())
			
			var pos_direction = get_viewport().size.x /2
			if get_position().x > pos_direction and spawn.has_method("apply_route"):
				spawn.direction = -1
			get_parent().add_child(spawn)
			get_node("Timer").set_wait_time(rand_range(min_spawn_time, max_spawn_time))
			get_node("Timer").start()
		else:
			get_node("Timer").start()
	else:
		var spawn = spawn_scene.instance()
		spawn.set_transform(get_transform())
		get_parent().add_child(spawn)
		get_node("Timer").set_wait_time(rand_range(min_spawn_time, max_spawn_time))
		get_node("Timer").start()
