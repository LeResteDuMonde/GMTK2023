extends Node

func _input(event):
	if event.is_action_pressed("mute"):
		AudioManager.mute()
	if event.is_action_pressed("fullscreen"):
		ScreenManager.fullscreen()
