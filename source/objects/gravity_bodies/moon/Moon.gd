extends StaticBody2D

export var gravity_strength := 400.0

var astromouse

func _ready():
	set_process_unhandled_input(false)


func spawn_cheeses(collision):
	var spawner = load("res://objects/spawners/CheeseSpawner.tscn").instance()
	var collision_position = collision.position
	var normal = collision.normal
	$Pivot.add_child(spawner)
	spawner.position = $Pivot.to_local(collision_position)
	spawner.rotation = normal.angle() + deg2rad(90 - $Pivot.rotation_degrees)
	spawner.spawn()


func spawn_crater(collision):
	var crater = load("res://objects/crater/Crater.tscn").instance()
	var pos = collision.position
	var normal = collision.normal
	$Pivot.add_child(crater)
	crater.position = $Pivot.to_local(pos)
	crater.rotation = normal.angle() + deg2rad(90 - $Pivot.rotation_degrees)
