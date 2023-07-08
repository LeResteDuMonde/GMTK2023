extends Node

var health = 4
var display

func _ready():
	display = GameManager.main.get_node("World/Health")
	udpateDisplay()
	
func damage():
	health -= 1
	if(health > 0): udpateDisplay()
	
func udpateDisplay():
	display.play(str(health))
