extends Node

var cursor

var open = load("res://sprite/cursor/HandBack.png")
var point = load("res://sprite/cursor/HandPoint.png")
var hold = load("res://sprite/cursor/HandHold.png")

func _ready():
#	cursor = GameManager.main.get_node("Cursor")
	Input.set_custom_mouse_cursor(point)
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func play(anim):
	cursor.play(anim)
	
var dragging = false
	
func hover():
	if not dragging:
#		cursor.play("open")
		Input.set_custom_mouse_cursor(open)
	
func unhover():
	if not dragging:
		Input.set_custom_mouse_cursor(point)
#		cursor.play("default")
	
func take():
	ShakeManager.shake(1.5,0.25)
	dragging = true
#	cursor.play("hold")
	Input.set_custom_mouse_cursor(hold)
	AudioManager.play("sounds/pickUp",3)
	
func release():
	dragging = false
	Input.set_custom_mouse_cursor(point)
#	cursor.play("default")

func release_hover():
	dragging = false
#	cursor.play("open")
	Input.set_custom_mouse_cursor(open)
	
func reset():
	release()
