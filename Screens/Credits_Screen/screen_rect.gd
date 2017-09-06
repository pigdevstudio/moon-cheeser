extends Control

func _ready():
	set_process(true)
	
func _process(delta):
	set_size(get_viewport().get_rect().size)
	pass

func _on_Animator_finished():
	get_parent().queue_free()
