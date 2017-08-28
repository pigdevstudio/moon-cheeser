extends RigidBody2D

signal died
signal finished_sfx
export (float) var jump_force = 300
var can_jump = true
var jump_normal = Vector2(0, -1)
onready var default_gravity_scale = get_gravity_scale()

func _ready():
	set_fixed_process(true)
	connect("died", get_parent().get_parent(), "change_to_next_scene", ["res://Screens/Score_Screen/ScoreScreen.tscn"])
		
func _fixed_process(delta):
	if not get_node("SFX").is_active():
		emit_signal("finished_sfx")

func jump():
	if can_jump:
		apply_impulse(Vector2(0,0), jump_force * jump_normal)
		get_node("Sprite").set_frame(2)
		get_node("Animator").stop()
		get_node("SFX").play("jumping")
	can_jump = false

func _body_enter( body ):
	if body.is_in_group("moon"):
		jump_normal = (get_pos() - body.get_pos()).normalized()
		rotate(get_angle_to(body.get_pos()))
		get_node("Animator").play("walking")
		can_jump = true
		
	elif body.is_in_group("enemy"):
		get_node("Sprite").hide()
		if body.is_in_group("void"):
			acheesements.modify_achievement("void", 1)
			get_node("SFX").play("falling")
		else:
			get_node("SFX").play("landing")
		yield(self, "finished_sfx")
		emit_signal("died")
		
	elif body.is_in_group("cheese"):
		body.increase_score()