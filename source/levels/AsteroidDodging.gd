extends Node2D

export (String, FILE, "*.tscn") var next_level

onready var animator = $AnimationPlayer
onready var starmouse = $Starmouse
onready var moon = $Moon
onready var astromouse_spawner = $AstromouseSpawner2D

func _ready():
	randomize()


func restart():
	get_tree().reload_current_scene()


func _on_StarMouse_finished():
	moon.astromouse = astromouse_spawner.spawn()
	animator.play("Completed")
	moon.set_process_input(true)
	moon.set_physics_process(true)


func _on_AsteroidDetectionArea2D_area_entered(area):
	starmouse.queue_free()
	animator.play("Dead")


func change_level(to = next_level):
	get_tree().change_scene(to)


func _on_MoonArea2D_body_entered(body):
	if body.name == "Astromouse":
		animator.play("Transit")
