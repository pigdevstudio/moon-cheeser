extends ColorRect

onready var _animator = $AnimationPlayer

func fade_in():
	_animator.play("FadeIn")
	yield(_animator, "animation_finished")
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func fade_out():
	mouse_filter = Control.MOUSE_FILTER_STOP
	_animator.play("FadeOut")
	yield(_animator, "animation_finished")
