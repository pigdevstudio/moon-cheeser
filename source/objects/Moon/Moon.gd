extends Node2D

var astromouse setget set_astromouse

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	var normal = (global_position - astromouse.global_position).normalized()
	$Gravity.direction = normal
	$Gravity.apply(astromouse)
	
func set_astromouse(new_astromouse):
	astromouse = new_astromouse
	astromouse.connect("tree_exited", self, "set_physics_process", [false])
	set_physics_process(true)