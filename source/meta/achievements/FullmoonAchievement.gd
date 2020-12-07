extends "res://meta/achievements/AchievementTrigger.gd"

func check_achievement():
	var day_difference = calculate_day_difference()
	
	if is_full_moon(day_difference):
		increase_progress()
	
func calculate_day_difference():
	var date = OS.get_date()
	var release = {"day":05, "month": 10, "year": 2017, "hour": 15,
			"minute": 41, "second": 23}
	date = OS.get_unix_time_from_datetime(date)
	release = OS.get_unix_time_from_datetime(release)
	
	var day_difference = (((date - release) / 60.0) / 60.0) / 24.0
	day_difference = day_difference / ceil(day_difference / 30)
	return day_difference

func is_full_moon(days_difference_from_release):
	var is_fullmoon = days_difference_from_release >= 29.0
	is_fullmoon = is_fullmoon and days_difference_from_release <= 30
	return is_fullmoon
