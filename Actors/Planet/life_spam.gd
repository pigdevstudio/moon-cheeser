extends CenterContainer

onready var progress_bar = get_node("ProgressBar")
onready var timer = get_node("Timer")
func _ready():
	progress_bar.set_max(timer.get_wait_time())
	set_process(true)
	
func _process(delta):
	progress_bar.set_value(timer.get_time_left())