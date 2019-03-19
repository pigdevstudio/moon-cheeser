extends Node2D

func _on_Animator_animation_finished(anim_name):
	queue_free()
