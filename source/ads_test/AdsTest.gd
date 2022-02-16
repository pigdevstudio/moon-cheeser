extends Control

var reward_amount = 0

onready var admob = $AdMob

func _ready():
	admob.load_banner()


func _on_BannerButton_pressed():
	admob.load_banner()
	admob.show_banner()


func _on_RewardsButton_pressed():
	admob.hide_banner()
	admob.load_rewarded_video()
	yield(admob, "rewarded_video_loaded")
	admob.show_rewarded_video()


func _on_AdMob_rewarded(currency, ammount):
	reward_amount += 1
	$Label.text = "Reward amount: %s" % reward_amount
