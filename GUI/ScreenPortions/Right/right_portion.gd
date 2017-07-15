tool
extends VBoxContainer



func _on_ScreenMargin_resolution_changed( resolution, manager ):
	if resolution <= manager.MEDIUM:
		get_node("RightButtons").hide()
		get_node("Languages").show()
	else:
		get_node("RightButtons").show()
		get_node("Languages").hide()
		
	if resolution <= manager.LOW:
		hide()
	else:
		show()