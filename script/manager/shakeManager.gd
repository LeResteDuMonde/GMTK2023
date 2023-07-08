extends Node

var camera
var shake_amount = 0

func shake(amount,time = 0):
	shake_amount = amount
	if(time > 0):
		await TimerManager.sleep(time)
		shake_amount = 0
	
func _ready():
	camera = GameManager.main.get_node("Camera2D")
	
func _process(delta):
	camera.set_offset(Vector2(randf_range(-1.0, 1.0) * shake_amount, randf_range(-1.0, 1.0) * shake_amount))
