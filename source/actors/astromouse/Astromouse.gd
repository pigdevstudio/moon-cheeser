extends KinematicBody2D

signal died

export var velocity = Vector2.ZERO
export var snap_vector = Vector2.DOWN * 32
export var up_direction = Vector2.UP

onready var jump = $Jump
onready var anim_tree = $AnimationTree


func _ready():
	jump.actor = self


func _physics_process(delta):
	move_and_slide_with_snap(velocity, snap_vector, up_direction, true, 1)
	if get_slide_count() > 0:
		var collision = get_slide_collision(0)
		up_direction = collision.get_normal()
		snap_vector = collision.get_normal().rotated(deg2rad(180)) * 32
		rotation = up_direction.angle() + deg2rad(90)
		anim_tree.set_condition("landed", true)
	if velocity.normalized().dot(up_direction) < 0:
		anim_tree.set_condition("falling", true)


func _unhandled_input(event):
	if event.is_action("jump"):
		if event.is_pressed():
			jump.execute()
			get_tree().set_input_as_handled()
		else:
			jump.cancel()
			get_tree().set_input_as_handled()



func die():
	anim_tree.set_condition("dead", true)


func _on_Jump_executed():
	anim_tree.set_condition("jumping", true)


func _on_StarPickupArea_area_entered(area):
	queue_free()


func _on_CraterDetectionArea2D_area_entered(area):
	die()
