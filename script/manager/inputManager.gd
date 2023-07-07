extends Node

func _input(event):
	if(event.is_action("escape")):
		GameManager.quit()
