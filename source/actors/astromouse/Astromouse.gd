extends "res://objects/SpaceKinematicBody.gd"

signal died

onready var character = $AstromouseCharacter
const FALL_SPEED = 50
func _ready():
	$Actions.space_kinematic_body = self
	
func _physics_process(delta):
	var relative_velocity = velocity.rotated(rotation)
	
	if relative_velocity.y > FALL_SPEED:
		character.play("run_fall")

func _on_collided(collision):
	var collider = collision.collider
	var angle = get_angle_to(collider.global_position)
	angle -= deg2rad(90)
	rotate(angle)
	if collision.collider.is_in_group("moon"):
		$Actions/Jump.reset()
		character.play("running")

func _on_Jump_executed():
	character.play("run_jump")
	$SFX.play("Jump")

func get_action_node():
	return $Actions

func become_invincible():
	$Invincible.start()

func die():
	if $Invincible.time_left > 0.0:
		return
	$Shape.call_deferred("set_disabled", true)
	$PickupArea/CollisionShape2D.call_deferred("set_disabled", true)
	$SFX.play("Damage")
	yield($SFX, "finished")
	emit_signal("died")
	queue_free()
