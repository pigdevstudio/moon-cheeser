extends "res://objects/SpaceKinematicBody.gd"

func _ready():
	$Actions.kinematic_actor = self

func _on_Astromouse_collided(collision):
	var collider = collision.collider
	var angle = get_angle_to(collider.global_position)
	angle -= deg2rad(90)
	rotate(angle)
	$Actions/Jump.reset()
