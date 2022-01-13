extends AudioStreamPlayer

export var crossfade_duration = 1.0

onready var animator = $AnimationPlayer
onready var buffer = $CrossFadeBuffer

var channel = 0


func crossfade(audio_stream):
	animator.playback_speed = 1.0 / crossfade_duration
	if channel == 0:
		channel = 1
		buffer.stream = audio_stream
		animator.play("crossfade_a_b")
	else:
		channel = 0
		stream = audio_stream
		animator.play("crossfade_b_a")
