extends Control


func toggle_pause():
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused


func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()


func _on_Button_pressed():
	toggle_pause()
