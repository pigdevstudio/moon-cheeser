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

onready var t = get_node("Tween")
onready var initial_pos = get_global_pos()
export (String) var group
export (String) var achievement
func _ready():
	if acheesements.dict[achievement].accomplished >= 3 or acheesements.already_played == true:
		queue_free()

func _on_collision_enter( collider ):
	if collider.is_in_group(group):
		if collider.route_already_changed:
			queue_free()
		else:
			get_tree().set_pause(true)
			var anim = get_node("../Fade/Animator")
			anim.play("fade")
			yield(anim, "finished")
			t.interpolate_property(self, "transform/pos", initial_pos, collider.get_global_pos(), 1.0, t.TRANS_BACK, t.EASE_IN_OUT)
			t.start()
			yield(t, "tween_complete")
			var hand = get_node("Hand")
			hand.get_node("Button").show()
			t.interpolate_property(hand, "transform/rot", hand.get_rot(), -24, 1.0, t.TRANS_BACK, t.EASE_IN_OUT)
			t.start()
			yield(t, "tween_complete")
			hand.get_node("Button").hide()
			t.interpolate_property(self, "transform/pos", get_global_pos(), initial_pos, 1.0, t.TRANS_BACK, t.EASE_IN_OUT)
			t.start()
			yield(t, "tween_complete")
			anim.play_backwards("fade")
			yield(anim, "finished")
			get_tree().set_pause(false)
			if group == "comet":
				collider.slide(-1)
			else:
				collider.slide(1)
			queue_free()