extends Node2D

export (NodePath) var astromouse_path
onready var astromouse = get_node(astromouse_path)

export (NodePath) var moon_path
onready var moon = get_node(moon_path) 

onready var _tween = $Tween
onready var _animator = $AnimationPlayer
onready var _hand_right = $GodHandRight
onready var _hand_left = $GodHandLeft
onready var _achievement = $TutorialAchievement

func _ready():
	if Achievements.get_progress(_achievement.achievement_name) > 0:
		_animator.play("Finished")


func _on_StarArea2D_body_entered(body):
	get_tree().paused = true
	_animator.play("Overlay")
	yield(_animator, "animation_finished")
	
	var initial_position = _hand_right.global_position
	var target_position = body.global_position
	_tween.interpolate_property(_hand_right, "global_position", 
			initial_position, target_position, 1.0,
			Tween.TRANS_BACK, Tween.EASE_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")
	
	_animator.play("Star")
	yield(_animator, "animation_finished")
	body.direction = body.global_position.direction_to(astromouse.global_position)
	
	_animator.play_backwards("Overlay")
	yield(_animator, "animation_finished")
	get_tree().paused = false
	
	_tween.interpolate_property(_hand_right, "global_position", 
			target_position, initial_position, 1.0,
			Tween.TRANS_BACK, Tween.EASE_OUT)
	_tween.start()
	_achievement.increase_progress()
	if body.is_inside_tree():
		yield(body, "tree_exited")
	_animator.play("Finished")


func _on_CometArea2D_body_entered(body):
	get_tree().paused = true
	_animator.play("Overlay")
	yield(_animator, "animation_finished")
	
	var initial_position = _hand_left.global_position
	var target_position = body.global_position
	_tween.interpolate_property(_hand_left, "global_position", 
			initial_position, target_position, 1.0,
			Tween.TRANS_BACK, Tween.EASE_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed")
	
	_animator.play("Comet")
	yield(_animator, "animation_finished")
	body.direction = body.global_position.direction_to(moon.global_position)
	
	_animator.play_backwards("Overlay")
	yield(_animator, "animation_finished")
	get_tree().paused = false
	
	_tween.interpolate_property(_hand_left, "global_position", 
			target_position, initial_position, 1.0,
			Tween.TRANS_BACK, Tween.EASE_OUT)
	_tween.start()
