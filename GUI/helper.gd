extends Node2D

onready var t = get_node("Tween")
onready var initial_pos = get_global_pos()
func _ready():
	if acheesements.dict["firststep"].accomplished >= 3:
		queue_free()

func _on_collision_enter( collider ):
	if collider.is_in_group("comet") and !collider.route_already_changed:
		get_tree().set_pause(true)
		var anim = get_node("../Fade/Animator")
		anim.play("fade")
		yield(anim, "finished")
		t.interpolate_property(self, "transform/pos", initial_pos, collider.get_global_pos(), 1.0, t.TRANS_BACK, t.EASE_IN_OUT)
		t.start()
		yield(t, "tween_complete")
		var hand = get_node("Hand")
		hand.get_node("Button").show()
		hand.get_node("Particles").set_emitting(true)
		t.interpolate_property(hand, "transform/rot", hand.get_rot(), -24, 1.0, t.TRANS_BACK, t.EASE_IN_OUT)
		t.start()
		yield(t, "tween_complete")
		hand.get_node("Button").hide()
		hand.get_node("Particles").hide()
		t.interpolate_property(self, "transform/pos", get_global_pos(), initial_pos, 1.0, t.TRANS_BACK, t.EASE_IN_OUT)
		t.start()
		yield(t, "tween_complete")
		anim.play_backwards("fade")
		yield(anim, "finished")
		get_tree().set_pause(false)
		collider.slide(-1)
		queue_free()
	else:
		queue_free()