extends "res://objects/GravityBody.gd"

func _ready():
	set_process_unhandled_input(false)


func spawn_cheeses(collision):
	var spawner = load("res://objects/Spawner/CheeseSpawner.tscn").instance()
	var pos = collision.position
	var normal = collision.normal
	$Pivot.add_child(spawner)
	spawner.position = $Pivot.to_local(pos)
	spawner.rotation = normal.angle() + deg2rad(90 - $Pivot.rotation_degrees)
	spawner.spawn()


func spawn_crater(collision):
	var crater = load("res://objects/Crater/Crater.tscn").instance()
	var pos = collision.position
	var normal = collision.normal
	$Pivot.add_child(crater)
	crater.position = $Pivot.to_local(pos)
	crater.rotation = normal.angle() + deg2rad(90 - $Pivot.rotation_degrees)


func _unhandled_input(event):
	if event.is_action_pressed("jump"):
		pulse()
		$Tween.pulse()
