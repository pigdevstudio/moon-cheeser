extends Node2D

export var speed := 300.0
export var direction := Vector2.DOWN
export var score := 100


onready var _velocity := speed * direction

onready var _animator := $AnimationPlayer
onready var _sprite_animator := $Sprite/AnimationPlayer


func _physics_process(delta):
	translate(_velocity * delta)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_DestructionArea_area_entered(area):
	_animator.play("explode")
