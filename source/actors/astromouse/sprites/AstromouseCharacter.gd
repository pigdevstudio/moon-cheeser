extends Position2D

var animation = "" setget set_animation, get_animation

func play(animation):
	if not $animator.current_animation == animation:
		$animator.play(animation)

func set_animation(new_animation):
	$animator.play(new_animation)

func get_animation():
	return $animator.current_animation
