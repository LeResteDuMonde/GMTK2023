extends Node

var money = 100
var display

func _ready():
	display = GameManager.main.get_node("World/Money/Label")
	updateDisplay()

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
