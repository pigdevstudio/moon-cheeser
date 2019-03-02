extends "res://objects/space_flying_bodies/SpaceFlyingBody.gd"

func _on_collide(collision):
	if collision.collider.has_method("die"):
		collision.collider.die()
	._on_collided(collision)
