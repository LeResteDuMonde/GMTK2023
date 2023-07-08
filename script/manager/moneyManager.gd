extends Node

var money
@onready var display = GameManager.main.get_node("World/Money/Label")

func reset():
	money = 100
	updateDisplay()
	
func _ready():
	reset()

func pay(count):
	var paying = money > count
	if(paying): money -= count
	updateDisplay()
	
	return paying
	
func addMoney(count):
	money += count
	updateDisplay()
	
func updateDisplay():
#	print("money")
	display.text = str(money)
