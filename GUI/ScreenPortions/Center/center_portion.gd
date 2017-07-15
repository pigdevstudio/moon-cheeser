tool
extends VBoxContainer

func _on_ScreenMargin_resolution_changed( resolution, manager ):
	if resolution <= manager.MEDIUM:
		get_node("AchievementsPortion/AchievementsButton").hide()
		get_node("CenterButtons").show()
	else:
		get_node("AchievementsPortion/AchievementsButton").show()
		get_node("CenterButtons").hide()
		
	if resolution <= manager.LOW:
		self.hide()
	else:
		self.show()