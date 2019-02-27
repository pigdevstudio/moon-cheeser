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
	astromouse.connect("tree_exited", self, "set_gravity_enabled", [false])
	set_gravity_enabled(true)


func set_gravity_enabled(enabled):
	set_physics_process(enabled)
	set_process_unhandled_input(enabled)


func pulse():
	var current_strength = $Gravity.acceleration
	$Gravity.acceleration *= 10
	var normal = (global_position - astromouse.global_position).normalized()
	$Gravity.direction = normal
	
	$Gravity.apply(astromouse)
#	var t = $Tween
#	if not t.is_active():
#		t.interpolate_property($Pivot/Atmosphere, "scale", $Pivot/Atmosphere.scale, $Pivot/Atmosphere.scale + Vector2(0.25, 0.25),
#				0.5, t.TRANS_BACK, t.EASE_OUT)
#		t.start()
#		yield(t, "tween_completed")
#
#		t.interpolate_property($Pivot/Atmosphere, "scale", $Pivot/Atmosphere.scale, $Pivot/Atmosphere.scale - Vector2(0.25, 0.25),
#				0.5, t.TRANS_BACK, t.EASE_OUT)
#		t.start()
	$Gravity.acceleration = current_strength
