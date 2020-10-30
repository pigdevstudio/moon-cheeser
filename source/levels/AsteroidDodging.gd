extends Node2D


onready var animator = $AnimationPlayer
onready var astromouse = $AstromouseCharacter
onready var starmouse = $Starmouse

func _ready():
	randomize()


func restart():
	get_tree().reload_current_scene()


func _on_StarMouse_finished():
	animator.play("Completed")


func _on_AsteroidDetectionArea2D_area_entered(area):
	starmouse.queue_free()
	animator.play("Dead")


func _on_ShaderButton_pressed():
	OS.shell_open("https://itch.io/s/37948/moon-cheeser-blue-moon-update")


func _on_LinkButton_pressed():
	OS.shell_open("https://pigdev.studio/moon-cheeser")
