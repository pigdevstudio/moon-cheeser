extends Control

func _ready():
	set_process(true)
	
func _process(delta):
	set_size(OS.get_window_size())

func _on_Animator_finished():
	get_parent().queue_free()
