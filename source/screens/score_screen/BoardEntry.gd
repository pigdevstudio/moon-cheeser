extends HBoxContainer


var player_name = "Astromouse"
var player_score = "00000"

onready var name_label = $NameLabel
onready var score_label = $ScoreLabel


func _ready():
	update_labels()


func update_labels():
	name_label.text = "%s" % player_name
	score_label.text = "%s" % player_score
