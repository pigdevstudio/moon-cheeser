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
extends StaticBody2D
export var score = 1

func _ready():
	connect("exit_tree", get_parent(), "count_cheeses")

func float_around(offset):
	randomize()
	var t = get_node("Tween")
	t.interpolate_method(self, "set_pos", get_pos(), offset, 4, t.TRANS_ELASTIC, t.EASE_OUT)
	t.start()
	
func increase_score():
	score_handler.set_score(score)
	acheesements.modify_achievement("mooncheeser", 1)
	queue_free()
	
func move_towards(where):
	var t = get_node("Tween")
	var direction = (where - get_global_pos()).normalized()
	var target = get_global_pos() + (Vector2(100, 100) * direction)
	t.interpolate_method(self, "set_global_pos", get_global_pos(), target, 1.0, t.TRANS_BACK, t.EASE_IN_OUT)
	t.start()