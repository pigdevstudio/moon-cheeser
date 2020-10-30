# Represents a Hit dealt from the attacker perspective
extends Area2D

signal hit_landed

enum Teams { Player, Enemy }
export (Teams) var team = Teams.Player

export (PackedScene) var hit_scene


func apply_hit(hurt_box):
	if team == hurt_box.team:
		return
	hurt_box.get_hurt(hit_scene.instance())
	emit_signal("hit_landed")


func _on_area_entered(area):
	apply_hit(area)
