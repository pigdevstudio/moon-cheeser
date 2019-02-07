extends Area2D

var kinematic_actor

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	var normal = (global_position - kinematic_actor.global_position).normalized()
	kinematic_actor.get_gravity().direction = normal

func _on_body_entered(body):
	if body.has_method("get_gravity"):
		kinematic_actor = body
		body.connect("tree_exited", self, "set_physics_process", [false])
		set_physics_process(true)

func _on_body_exited(body):
	if body.has_method("get_gravity"):
		pass
