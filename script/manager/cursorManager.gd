extends Node

var cursor

func _ready():
	cursor = GameManager.main.get_node("Cursor")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func play(anim):
	cursor.play(anim)
	
var dragging = false
	
func hover():
	if not dragging:
		cursor.play("open")
	
func unhover():
	if not dragging:
		cursor.play("default")
	
func take():
	dragging = true
	cursor.play("hold")
	AudioManager.play("sounds/pickUp",3)
	
func release():
	dragging = false
	cursor.play("default")

func release_hover():
	dragging = false
	cursor.play("open")
	
func reset():
	release()
