tool
extends Line2D

func _draw():
	$EndMask.enabled = end_cap_mode == LINE_CAP_ROUND
	$EndMask.position = points[points.size() - 1]
	
	var proportion = width / $EndMask.texture.get_size().x
	$EndMask.texture_scale = proportion
