extends Node2D


const ATTACK_THRESHOLD = 2
const HURT_THRESHOLD = 10
const HEALTH_THREHOLD = 0.3
const SLAPS = ["left_slap", "right_slap"]
const LASERS = ["left_laser", "right_laser"]
const SUPER = ["mouth_attack"]

var _attack_set = SLAPS
var _hurt_count = 0
var _idle_repetitions = 0

onready var _anim_tree = $AnimationTree
onready var _damage_animator = $DamageAnimationPlayer
onready var _health = $Health

func _ready():
	randomize()


func increase_idle_repetitions():
	_idle_repetitions += 1
	
	if _idle_repetitions > ATTACK_THRESHOLD:
		attack()


func attack():
	_idle_repetitions = 0
	if _hurt_count > HURT_THRESHOLD:
		_attack_set = LASERS
		_hurt_count = 0
		if _health.current <= _health.max_amount * HEALTH_THREHOLD:
			_attack_set = SUPER
	else:
		_attack_set = SLAPS
	var condition = _attack_set[randi()%_attack_set.size()]
	_anim_tree.set_condition(condition, true)


func _on_Health_changed(new_amount):
	_hurt_count += 1


func _on_Health_depleted():
	_anim_tree.set_condition("dead", true)


func _on_HurtBox_damage_taken(damage) -> void:
	_health.current -= damage
	_damage_animator.play("damaged")
