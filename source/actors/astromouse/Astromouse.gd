extends KinematicBody2D

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
	if velocity.rotated(rotation).y < 0.0:
		anim_tree.set_condition("falling", true)


func _unhandled_input(event):
	if not event.is_action("jump"):
		return
	if event.is_pressed():
		jump.execute()
	else:
		jump.cancel()


func _on_Jump_executed() -> void:
	anim_tree.set_condition("jumping", true)
