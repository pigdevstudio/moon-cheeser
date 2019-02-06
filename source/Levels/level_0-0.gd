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
extends Node

export (int, "NORMAL", "GRAVITATIONAL_BATTLE") var game_state setget set_game_state, get_game_state

func _ready():
	connect("exit_tree", acheesements, "write_achievements")
	
func set_game_state(state):
	if is_inside_tree():
		if state == 0:
			get_tree().get_nodes_in_group("player")[0].set_gravity_scale(12)
		elif state == 1:
			get_tree().call_group(SceneTree.GROUP_CALL_DEFAULT, "crater", "queue_free")
			get_tree().call_group(SceneTree.GROUP_CALL_DEFAULT, "space_body", "queue_free")
	game_state = state

func get_game_state():
	return(game_state)