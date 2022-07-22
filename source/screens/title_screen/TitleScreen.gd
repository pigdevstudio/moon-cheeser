extends Control

export(String, FILE, "*.tscn") var game_scene
export(String, FILE, "*.tscn") var achievements_scene
export(String, FILE, "*.tscn") var skins_scene
export(String, FILE, "*.tscn") var leaderboard_scene

onready var _fade_rect = $FadeRect
onready var _admob = $AdMob

func _ready():
	match OS.get_name():
		"HTML5", "Windows", "X11":
			if not LootLocker.token:
				LootLocker.player_id = OS.get_unique_id()
				LootLocker.authenticate_guest_session()
		"Android":
			_admob.load_banner()
			yield(_admob, "banner_loaded")
			$AdMob/Timer.start()
			_admob.show_banner()


func change_scene(next_scene_path):
	_admob.hide_banner()
	yield(_fade_rect.fade_out(), "completed")
	get_tree().change_scene(next_scene_path)


func _on_PlayButton_pressed():
	change_scene(game_scene)
	_admob.hide_banner()

func _on_AchievementsButton_pressed():
	change_scene(achievements_scene)
	_admob.hide_banner()


func _on_SkinsButton_pressed():
	change_scene(skins_scene)
	_admob.hide_banner()


func _on_LeaderboardButton_pressed():
	change_scene(leaderboard_scene)
	_admob.hide_banner()


func _on_AdMobTimer_timeout():
	_admob.hide_banner()
