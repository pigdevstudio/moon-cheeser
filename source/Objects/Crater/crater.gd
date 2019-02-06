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

onready var tween = get_node("Tween")
onready var timer = get_node("Timer")

func _ready():
	if get_tree().get_nodes_in_group("crater").size() >= 5:
		acheesements.modify_achievement("madness", 1)
	get_node("Particles").set_emitting(true)
	tween.interpolate_property(self, "transform/scale", Vector2(0, 0), get_scale(), 
	0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_complete")
	timer.set_wait_time(rand_range(4,12))
	timer.start()

func _on_timeout():
	tween.interpolate_property(self, "transform/scale", get_scale(), Vector2(0, 0), 
	0.5, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_complete")
	queue_free()