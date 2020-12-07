extends Node2D

onready var t = get_node("Tween")
export (String) var group
export (String) var achievement
func _ready():
	if acheesements.dict[achievement].accomplished >= 3 or acheesements.already_played == true:
		queue_free()

func _on_collision_enter(collider):
	if collider.is_in_group(group):
		if collider.route_already_changed:
			queue_free()
		else:
			var initial_pos = global_position
			get_tree().set_pause(true)
#			var anim = get_node("../Fade/Animator")
#			anim.play("fade")
#			yield(anim, "animation_finished")
			t.interpolate_property(self, "global_position", initial_pos, collider.global_position, 1.0, t.TRANS_BACK, t.EASE_IN_OUT)
			t.start()
			yield(t, "tween_completed")
			var hand = get_node("Hand")
			hand.get_node("Button").show()
			t.interpolate_property(hand, "rotation_degrees", hand.rotation_degrees, 24, 1.0, t.TRANS_BACK, t.EASE_IN_OUT)
			t.start()
			yield(t, "tween_completed")
			hand.get_node("Button").hide()
			t.interpolate_property(self, "global_position", global_position, initial_pos, 1.0, t.TRANS_BACK, t.EASE_IN_OUT)
			t.start()
			yield(t, "tween_completed")
#			anim.play_backwards("fade")
#			yield(anim, "animation_finished")
			get_tree().set_pause(false)
			if group == "comet":
				collider.slide(-1)
			else:
				collider.slide(1)
			queue_free()
