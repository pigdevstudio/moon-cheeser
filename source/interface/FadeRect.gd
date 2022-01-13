extends Control

export (String, FILE, "*.tscn") var next_scene_path

onready var _animator = $AnimationPlayer


func _ready():
	fade_in()


func change_scene(scene_path = next_scene_path):
	yield(fade_out(), "completed")
	get_tree().change_scene(scene_path)


func fade_in():
	_animator.play("FadeIn")
	yield(_animator, "animation_finished")
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func fade_out():
	mouse_filter = Control.MOUSE_FILTER_STOP
	_animator.play("FadeOut")
	yield(_animator, "animation_finished")
