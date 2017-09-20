extends RigidBody2D

signal died
signal finished_sfx
export (float) var jump_force = 300
var can_jump = true
var invulnerable = true
var jump_normal = Vector2(0, -1)
onready var default_gravity_scale = get_gravity_scale()

func _ready():
	if acheesements.dict["mooncheeser"].accomplished >= acheesements.dict["mooncheeser"].total:
		get_node("Sprite").set_texture(load("res://Actors/Astromouse/true_astro_spritesheet.png"))
	set_fixed_process(true)
	connect("died", get_parent().get_parent(), "change_to_next_scene", ["res://Screens/Score_Screen/ScoreScreen.tscn"])
		
func _fixed_process(delta):
	if not get_node("SFX").is_active():
		emit_signal("finished_sfx")
	is_falling()
func jump():
	if can_jump:
		apply_impulse(Vector2(0,0), jump_force * jump_normal)
		get_node("Sprite").set_frame(2)
		get_node("Animator").stop()
		get_node("SFX").emit_signal("is_playing", "jumping")
	can_jump = false

func _body_enter( body ):
	if body.is_in_group("moon"):
		jump_normal = (get_pos() - body.get_pos()).normalized()
		rotate(get_angle_to(body.get_pos()))
		get_node("Animator").play("walking")
		can_jump = true
		
	elif body.is_in_group("enemy"):
		if body.is_in_group("void"):
			acheesements.modify_achievement("void", 1)
			get_node("SFX").play("falling")
			get_node("Animator").play("death")
			yield(self, "finished_sfx")
			emit_signal("died")
		elif not invulnerable:
			get_node("Sprite").hide()
			get_node("SFX").play("damage")
			yield(self, "finished_sfx")
			emit_signal("died")
		
	elif body.is_in_group("cheese"):
		get_node("SFX").emit_signal("is_playing", "pickup")
		body.increase_score()
		
func is_falling():
	if get_parent().get_game_state() == 0:
		var normal = (get_node("../Moon").get_pos() - get_pos()).normalized()
		var falling_speed = normal.dot(get_linear_velocity())
		if falling_speed > 5 and falling_speed < 60:
			get_node("Sprite").set_frame(1)
			rotate(get_angle_to(get_node("../Moon").get_pos()))
			return(true)
		elif falling_speed > 100:
			get_node("Sprite").set_frame(3)
			return(true)
		else:
			return(false)

func _invulnerability():
	invulnerable = false
