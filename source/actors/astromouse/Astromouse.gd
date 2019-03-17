extends "res://objects/SpaceKinematicBody.gd"

signal died

func _ready():
	$Actions.space_kinematic_body = self

func _on_collided(collision):
	var collider = collision.collider
	var angle = get_angle_to(collider.global_position)
	angle -= deg2rad(90)
	rotate(angle)
	if collision.collider.is_in_group("moon"):
		$Actions/Jump.reset()
		$AnimatedSprite.play("Run")

func _on_Jump_executed():
	$AnimatedSprite.play("Jump")
	$AnimatedSprite.frame = 0
	$SFX.play("Jump")
	yield($AnimatedSprite, "animation_finished")
	$AnimatedSprite.play("Fall")

func get_action_node():
	return $Actions

func die():
	$Shape.call_deferred("set_disabled", true)
	$PickupArea/CollisionShape2D.call_deferred("set_disabled", true)
	$SFX.play("Damage")
	yield($SFX, "finished")
	emit_signal("died")
	queue_free()
