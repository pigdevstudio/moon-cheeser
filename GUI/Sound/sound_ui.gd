tool
extends HBoxContainer

func _on_ScreenMargin_resolution_changed( resolution, manager ):
	if resolution <= manager.MEDIUM:
		get_node("VSlider").show()
		get_node("HSlider").hide()
	elif resolution >= manager.MEDIUM:
		get_node("VSlider").hide()
		get_node("HSlider").show()