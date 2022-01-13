extends Node2D

export (String) var pulling_group
export (float) var pull_strength = 300

func _physics_process(delta):
	var ratio = $Animator.current_animation_position / $Animator.current_animation_length
	for node in get_tree().get_nodes_in_group(pulling_group):
		var direction = (global_position - node.global_position).normalized()
		node.global_translate(direction * (pull_strength * delta) * ratio)
	
func _on_Animator_animation_finished(anim_name):
	queue_free()
