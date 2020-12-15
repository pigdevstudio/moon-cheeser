extends Node2D

signal astromouse_died
signal finished

export (String, FILE, "*.tscn") var next_level_path

onready var animator = $AnimationPlayer
onready var starmouse = $Starmouse
onready var moon = $Moon
onready var astromouse_spawner = $AstromouseSpawner2D

func _ready():
	randomize()


func restart():
	emit_signal("astromouse_died")


func _on_StarMouse_finished():
	moon.astromouse = astromouse_spawner.spawn()
	animator.play("Completed")
	moon.set_process_input(true)
	moon.set_physics_process(true)


func _on_AsteroidDetectionArea2D_area_entered(area):
	starmouse.queue_free()
	animator.play("Dead")


func finish_level():
	emit_signal("finished")


func _on_MoonArea2D_body_entered(body):
	if body.name == "Astromouse":
		animator.play("Transit")
