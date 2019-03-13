extends ColorRect

onready var animator = $AnimationPlayer
signal finished

func fade_in():
	animator.play("fade")
	
func fade_out():
	animator.play_backwards("fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("finished")
