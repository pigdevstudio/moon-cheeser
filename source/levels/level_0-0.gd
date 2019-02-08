extends Node

func _ready():
	$Moon.astromouse = $Astromouse
	$Moon.set_physics_process(true)
