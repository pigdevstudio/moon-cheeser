extends KinematicBody2D
signal collided(collision)

var velocity = Vector2(0, 0)

func _ready():
	$Physics.kinematic_actor = self
	$Actions.kinematic_actor = self

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		emit_signal("collided", collision)

func get_gravity():
	return $Physics/Gravity

func get_jump():
	return $Actions/Jump
