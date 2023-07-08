extends Node

var cursor

func _ready():
	cursor = GameManager.main.get_node("Cursor")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func play(anim):
	cursor.play(anim)
	
