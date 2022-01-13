extends Node2D


export var speed = 400.0
export var direction = Vector2.LEFT

var velocity = speed * direction

func _physics_process(delta):
	velocity = speed * direction
	translate(velocity * delta)
