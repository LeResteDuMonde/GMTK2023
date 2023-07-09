extends Node

var isFullScreen = false

var fullscreenSprite = preload("res://sprite/fullscreen/fullscreenButton.png")
var windowSprite = preload("res://sprite/fullscreen/windowButton.png")

var fullscreenButton

func _ready():
	fullscreenButton = GameManager.main.get_node("Titles/Title/FullscreenButton")
	
func fullscreen():
	if(isFullScreen):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreenButton.texture = fullscreenSprite
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreenButton.texture = windowSprite
	
	isFullScreen = !isFullScreen
