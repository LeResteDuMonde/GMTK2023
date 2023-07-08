extends AnimatedSprite2D

func _process(delta):
	global_position = lerp(global_position, get_global_mouse_position(), 50 * delta)
