extends Node

var kinematic_actor

func _physics_process(delta):
	for force in get_children():
		force.apply(kinematic_actor)

func _on_Astromouse_collided(collision):
	var collider = collision.collider
	var angle = kinematic_actor.get_angle_to(collider.global_position)
	angle -= deg2rad(90)
	kinematic_actor.rotate(angle)
