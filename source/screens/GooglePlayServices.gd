extends Node


func login():
	if Engine.has_singleton("GodotPlayGamesServices"):
		var play_games_services
		play_games_services = Engine.get_singleton("GodotPlayGamesServices")
	
		var show_popups = true
		var request_email = true
		var request_profile = true
		var request_token = ""
		
		play_games_services.init(show_popups, request_email, request_profile, request_token)
		play_games_services.connect("_on_sign_in_success", self, "_on_sign_in_success")
		play_games_services.connect("_on_sign_in_failed", self, "_on_sign_in_failed")
		
		play_games_services.signIn()


func _on_sign_in_success(account_data):
	if not LootLocker.token:
		LootLocker.player_id = account_data['id']
		LootLocker.authenticate_guest_session()


func _on_sign_in_failed(error_code):
	NetworkStateLabel.show()
	NetworkStateLabel.text = "login failed. \n error: %s" % error_code
