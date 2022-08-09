extends Node

export(int) var score_threshold = 1000

onready var http_request = $HTTPRequest

func _ready():
	Score.connect("scored", self, "_on_Score_scored")


func trigger_skin_unlock():
	AchievementLabel.text = "new skin unlocked!! \n "
	AchievementLabel.show()
	
	Score.disconnect("scored", self, "_on_Score_scored")
	
	var url = "https://api.lootlocker.io/game/v1/player/trigger"
	var header = ["Content-Type: application/json", "x-session-token: %s" % LootLocker.token]
	var method = HTTPClient.METHOD_POST
	var body = {
		"name": "new_skin_unlocked"
	}
	http_request.request(url, header, false, method, to_json(body))
	
	var response = yield(http_request, "request_completed")[3]
	response = JSON.parse(response.get_string_from_utf8()).result
	
	var asset_name = response['granted_assets'][0]['name']
	
	AchievementLabel.text = "new skin unlocked!! \n %s" % asset_name.to_lower()
	yield(get_tree().create_timer(2.0), "timeout")
	AchievementLabel.hide()


func _on_Score_scored():
	if Score.current_score >= score_threshold:
		trigger_skin_unlock()
