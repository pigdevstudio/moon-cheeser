extends KinematicBody2D
signal collided(collision)

var velocity = Vector2(0, 0)

func _ready():
	$Actions.kinematic_actor = self

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = Vector2(0, 0)
		emit_signal("collided", collision)

func _on_Astromouse_collided(collision):
	var collider = collision.collider
	var angle = get_angle_to(collider.global_position)
	angle -= deg2rad(90)
	rotate(angle)
