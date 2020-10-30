extends Node


export (String, FILE, "*.tscn") var next_scene


func _ready():
	BGM.stop()


func _unhandled_key_input(event):
	if event.get_scancode() == KEY_SPACE:
		$AnimationPlayer.play("Collision")


func transit():
	get_tree().change_scene(next_scene)
