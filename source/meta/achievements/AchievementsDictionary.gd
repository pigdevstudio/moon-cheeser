extends Node

signal achievement_completed(achievement_name)

export(String, FILE) var FILE_PATH = ""

const USER_PATH = "user://achievements.json"
var _dict = {}

func _ready():
	read_achievements()

func read_achievements():
	var file = File.new()
	if file.file_exists(USER_PATH):
		file.open(USER_PATH, file.READ)
		var text = file.get_as_text()
		_dict = parse_json(text)
		file.close()
	else:
		file.open(FILE_PATH, file.READ)
		var text = file.get_as_text()
		_dict = parse_json(text)
		file.close()
		write_achievements()

func write_achievements():
	var file = File.new()
	file.open(USER_PATH, file.WRITE_READ)
	file.store_string(to_json(_dict))
	file.close()

func set_achievement_progress(achievement_name, new_value):
	var achievement = _get_achievement(achievement_name)
	var is_complete = is_achievement_complete(achievement_name)
	
	if not is_complete:
		achievement["accomplished"] = new_value
		_dict[achievement_name] = achievement
		is_complete = is_achievement_complete(achievement_name)
		if is_complete:
			write_achievements()
			emit_signal("achievement_completed", achievement_name)

func _get_achievement(achievement_name):
	return _dict[achievement_name]

func get_goal(achievement_name):
	var achievement = _get_achievement(achievement_name)
	var goal = achievement["total"]
	return goal

func get_progress(achievement_name):
	var achievement = _get_achievement(achievement_name)
	var progress = achievement["accomplished"]
	return progress

func get_description(achievement_name):
	var achievement = _get_achievement(achievement_name)
	var description = achievement["description"]
	return description
	
func get_title(achievement_name):
	var achievement = _get_achievement(achievement_name)
	var title = achievement["name"]
	return title
	
func is_achievement_complete(achievement_name):
	var achievement = _get_achievement(achievement_name)
	var progress = get_progress(achievement_name)
	var goal = get_goal(achievement_name)
	
	var is_complete = progress >= goal
	return is_complete
