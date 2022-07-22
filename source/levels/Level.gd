extends Node2D

signal astromouse_died
signal finished

export(String, FILE, "*.tscn") var next_level_path

var _starmouse
var _blackhole

onready var _astromouse = $Astromouse
onready var _moon = $Moon
onready var _blackhole_timer = $BlackholeSpawner/RandomTimer
onready var _starmouse_spawner = $StarmouseSpawner
onready var _supernova_spawner = $SupernovaSpawner
onready var _cheese_spawner = $CheeseSpawner
onready var _camera = $ShakingCamera2D


func _ready():
	_astromouse.connect("died", self, "_on_Astromouse_died")
	_astromouse.connect("tree_exited", self, "_on_Astromouse_tree_exited")
	randomize()


func _physics_process(delta):
	if _astromouse.is_on_floor():
		return
	var mouse_to_moon_direction = _astromouse.global_position.direction_to(_moon.global_position)
	_astromouse.velocity += mouse_to_moon_direction * (_moon.gravity_strength * delta)


func _setup_blackhole():
	if not _blackhole:
		return
	_blackhole.dummy.global_position = _astromouse.global_position
	_blackhole.set_physics_process(true)
	_blackhole.dummy.visible = true
	_moon.astromouse = _blackhole.dummy
	_moon.set_process_input(true)
	_moon.set_physics_process(true)
	remove_child(_astromouse)


func _unhandled_input(event):
	if not event is InputEventMouseButton:
		return
	if event.pressed:
		if _blackhole:
			_moon.pull()


func _on_Astromouse_died():
	set_physics_process(false)
	set_process_unhandled_input(false)
	remove_child(_astromouse)
	emit_signal("astromouse_died")


func _on_Astromouse_tree_exited():
	set_physics_process(false)
	set_process_unhandled_input(false)


func _on_BlackholeSpawner_spawned(spawn):
	_blackhole = spawn
	_blackhole.connect("finished", self, "_on_Blackhole_finished")
	_blackhole.connect("event_horizon_entered", self, "_on_Astromouse_died")
	
	if not _astromouse.is_inside_tree():
		return
	_setup_blackhole()


func _on_Blackhole_finished(dummy):
	add_child(_astromouse)
	_astromouse.global_position = dummy.global_position
	_astromouse.velocity = Vector2.ZERO
	_blackhole_timer.start()
	set_physics_process(true)
	_moon.set_process_input(false)
	_moon.set_physics_process(false)
	_blackhole = null


func _on_Star_collided(collision):
	var collider = collision.collider
	match collider.name:
		"Moon":
			_moon.spawn_crater(collision)
			_camera.shake()
		"Astromouse":
			if not _astromouse.is_inside_tree():
				return
			_starmouse_spawner.global_position = collision.position
			_starmouse_spawner.spawn()
			remove_child(_astromouse)
	if collider.is_in_group("star") and _supernova_spawner.get_child_count() < 1:
		_supernova_spawner.global_position = collision.position
		_supernova_spawner.spawn()
		_camera.shake()


func _on_StarmouseSpawner_spawned(spawn):
	_starmouse = spawn
	_starmouse.connect("finished", self, "_on_Starmouse_finished")


func _on_Starmouse_finished():
	add_child(_astromouse)
	set_physics_process(true)
	set_process_unhandled_input(false)
	_astromouse.global_position = _starmouse.global_position
	_astromouse.velocity = Vector2.ZERO
	_starmouse = null
	_setup_blackhole()


func _on_Comet_collided(collision):
	var collider = collision.collider
	match collider.name:
		"Moon":
			_moon.spawn_crater(collision)
			_camera.shake()
		"Astromouse":
			_astromouse.die()
	if collider.is_in_group("star") or collider.is_in_group("comet"):
		var cheese_spawner = _cheese_spawner.duplicate()
		add_child(cheese_spawner)
		cheese_spawner.global_position = collision.position
		cheese_spawner.spawn()
		_camera.shake()


func _on_RightStarSpawner_spawned(spawn):
	spawn.direction.x = -1
	spawn.connect("collided", self, "_on_Star_collided")


func _on_RightCometSpawner_spawned(spawn):
	spawn.direction.x = -1
	spawn.connect("collided", self, "_on_Comet_collided")


func _on_LeftStarSpawner_spawned(spawn):
	spawn.direction.x = 1
	spawn.connect("collided", self, "_on_Star_collided")


func _on_LeftCometSpawner_spawned(spawn):
	spawn.direction.x = 1
	spawn.connect("collided", self, "_on_Comet_collided")


func _on_FinishTimer_timeout():
	emit_signal("finished")


func _on_MoonPressArea2D_input_event(viewport, event, shape_idx):
	if not event is InputEventMouseButton:
		return
	if event.pressed:
		if _blackhole:
			_moon.pull()
