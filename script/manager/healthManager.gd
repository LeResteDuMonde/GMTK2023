extends Node

var health
@onready var display = GameManager.main.get_node("World/Health")

func reset():
	health = 4
	updateDisplay()

func _ready():
	reset()
	
func damage():
	health -= 1
	if(health > 0): updateDisplay()
	else: # Game Over :(
		GameManager.gameOver()
	
func updateDisplay():
	display.play(str(health))
