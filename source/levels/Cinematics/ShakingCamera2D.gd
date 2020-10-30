extends Camera2D


export var strength = 10.0
export var duration = 0.5
export var continuous = false

onready var _timer = $Timer

func _ready():
	set_process(false)


func _process(delta):
	offset.x = rand_range(-strength, strength)
	offset.y = rand_range(-strength, strength)


func shake():
	set_process(true)
	if not continuous:
		_timer.start(duration)


func stop():
	set_process(false)


func _on_Timer_timeout() -> void:
	set_process(false)
