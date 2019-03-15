extends ColorRect

onready var animator = $AnimationPlayer
signal finished

func fade_in():
	animator.play("fade")
	yield(animator, "animation_finished")
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func fade_out():
	mouse_filter = Control.MOUSE_FILTER_STOP
	animator.play_backwards("fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("finished")
