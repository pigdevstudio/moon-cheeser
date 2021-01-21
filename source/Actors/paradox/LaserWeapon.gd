extends Node2D

onready var _beam = $LaserBeam2D
onready var _beam_particles = $LaserBeam2D/BeamParticles2D
onready var _beam_material = $LaserBeam2D/BeamParticles2D.process_material
onready var _hit_collision_shape = $HitBox2D/CollisionShape2D
onready var _hit_shape = $HitBox2D/CollisionShape2D.shape
onready var _hit_box = $HitBox2D
onready var _timer = $Timer


func _ready():
	_hit_collision_shape.disabled = true


func _physics_process(delta):
	_hit_box.position = _beam_particles.position
	_hit_shape.extents.x = _beam_material.emission_box_extents.x
	_hit_shape.extents.y = _beam_material.emission_box_extents.y


func fire():
	_hit_collision_shape.disabled = false
	_beam.is_casting = true
	set_physics_process(true)
	_timer.start()


func stop():
	_hit_collision_shape.disabled = true
	_beam.is_casting = false
	set_physics_process(false)
	_timer.stop()


func _on_Timer_timeout() -> void:
	if is_physics_processing():
		_hit_collision_shape.disabled = not _hit_collision_shape.disabled
