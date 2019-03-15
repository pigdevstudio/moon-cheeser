extends CanvasLayer

signal screen_changed(new_screen)

const PLAY_SCREEN_PATH = "res://screens/play_screen/PlayScreen.tscn"
const CREDITS_SCREEN_PATH = "res://screens/credits_screen/CreditsScreen.tscn"
const ACHIEVEMENTS_SCREEN_PATH = "res://screens/achievements_screen/AchievementsScreen.tscn"
const TITLE_SCREEN_PATH = "res://screens/title_screen/TitleScreen.tscn"

export (PackedScene) var next_screen = preload(TITLE_SCREEN_PATH)

func _ready():
	var current_screen = get_child(0)
	current_screen.fade_in()
	
func change_screen(new_screen = next_screen):
	var current_screen = get_child(0)
	if current_screen.is_fading():
		return
	
	current_screen.fade_out()
	yield(current_screen, "faded")
	current_screen.queue_free()
	
	new_screen = new_screen.instance()
	add_child(new_screen)
	new_screen.fade_in()
	new_screen.connect("button_up", self, "_on_Screen_button_up")
	
	emit_signal("screen_changed", new_screen)
	
func _on_Screen_button_up(button):
	var screen_path = ""
	
	match button.name:
		"Achievements":
			screen_path = ACHIEVEMENTS_SCREEN_PATH
		"Credits":
			screen_path = CREDITS_SCREEN_PATH
		"Play":
			screen_path = PLAY_SCREEN_PATH
		"Retry":
			screen_path = PLAY_SCREEN_PATH
		"Back":
			screen_path = TITLE_SCREEN_PATH
	
	if not screen_path:
		return
	next_screen = load(screen_path)
	change_screen()
