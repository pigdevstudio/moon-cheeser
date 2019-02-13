extends Node2D

var astromouse setget set_astromouse

func _ready():
	set_physics_process(false)


func _physics_process(delta):
	var normal = (global_position - astromouse.global_position).normalized()
	$Gravity.direction = normal
	$Gravity.apply(astromouse)


func set_astromouse(new_astromouse):
	astromouse = new_astromouse
	astromouse.connect("tree_exited", self, "set_physics_process", [false])
	set_physics_process(true)


func spawn_cheeses(collision):
	var spawner = load("res://objects/Spawner/CheeseSpawner.tscn").instance()
	var pos = collision.position
	var normal = collision.normal
	$Pivot.add_child(spawner)
	spawner.position = $Pivot.to_local(pos)
	spawner.rotation = normal.angle() + deg2rad(90 - $Pivot.rotation_degrees)
	spawner.spawn()

