extends "res://objects/spawners/Spawner.gd"

func _ready():
	get_tree().connect("node_added", self, "_on_SceneTree_node_added")
	
func _on_SceneTree_node_added(node):
	if node.is_in_group("star"):
		node.connect("collided", self, "_on_Star_collided")

func _on_Star_collided(collision):
	global_position = collision.position
	if not get_parent().has_node("Supernova") and collision.collider.is_in_group("star"):
		spawn()
