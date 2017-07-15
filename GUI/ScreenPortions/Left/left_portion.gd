tool
extends VBoxContainer

func _on_ScreenMargin_resolution_changed( resolution, manager ):
	if resolution <= manager.LOW:
		hide()
	else:
		show()