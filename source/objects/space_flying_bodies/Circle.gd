tool
extends Node2D

export (Color) var color = Color.white setget set_color
export (float) var radius = 16.0 setget set_radius

func _draw():
	draw_circle(Vector2.ZERO, radius, color)


func set_color(new_color):
	color = new_color
	update()


func set_radius(new_radius):
	if new_radius < 0.0:
		return
	radius = new_radius
	update()
