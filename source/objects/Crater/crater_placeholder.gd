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

func _ready():
	randomize()

func count_cheeses():
	if get_child_count() <= 0:
		queue_free()
		
func spawn_cheeses(type):
	if type == 0:
		var max_cheeses = round(rand_range(4, 8))
		for i in range(0,max_cheeses):
			var c = load("res://objects/Cheese/Cheese.tscn").instance()
			add_child(c)
			c.float_around(c.get_position() + Vector2(rand_range(-50, 50), rand_range(150, 320)) * -1)
	elif type == 1:
		var max_cheeses = round(rand_range(4, 8))
		for i in range(0,max_cheeses):
			var c = load("res://objects/Cheese/Cheese.tscn").instance()
			add_child(c)
			c.float_around(c.get_position() + Vector2(rand_range(-100, 100), rand_range(-100, 100)))
	elif type == 2:
		var c = load("res://objects/Cheese/Cheddar.tscn").instance()
		add_child(c)
		c.float_around(c.get_position() + Vector2(rand_range(-20, 20), rand_range(-20, 20)))
