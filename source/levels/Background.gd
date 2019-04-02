extends Node2D

func show_crux():
	$Crux/Animator.play("fade")
	
func hide_crux():
	$Crux/Animator.play_backwards("fade")
