extends Node

"""
An audio library that wraps AudioSamplePlayers and provides an easy
interface method to play them.
"""

signal finished

func _ready():
	randomize()

"""
Empty strings create a default NodePath which points to the nodeshots I itself
so to avoid stackoverflows I use a dummy_node_path that ideally points
to an non existent child, therefore calling a random one by default
"""
func play(sound_effect = "dummy_node_path"):
	if has_node(sound_effect):
		sound_effect = get_node(sound_effect)
	else:
		var child_index = randi()%get_child_count()
		sound_effect = get_child(child_index)
	
	sound_effect.play()
	yield(sound_effect, "finished")
	emit_signal("finished")
