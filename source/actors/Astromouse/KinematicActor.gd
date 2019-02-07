extends KinematicBody2D
signal collided(collision)

export (Vector2) var floor_normal = Vector2(0, 1)
var velocity = Vector2(0, 0)

func _ready():
	$Physics.kinematic_actor = self
	$Actions.kinematic_actor = self

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.is_in_group("moon"):
			#Offset by -90 degrees to make the character always point
			#up relative to the collider's center
			rotate(get_angle_to(collision.collider.global_position) - deg2rad(90))
			emit_signal("collided", collision)

func get_gravity():
	return $Physics/Gravity
