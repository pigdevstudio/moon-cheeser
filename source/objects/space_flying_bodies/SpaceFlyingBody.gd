extends "../SpaceKinematicBody.gd"

"""
A flying body that fly towards a given speed at a given direction
"""

func _on_DragArea_dragged(_direction):
	set_direction(_direction)


func _on_DragArea_dragging():
	stop()
