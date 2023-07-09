extends Node

var money

@onready var display = GameManager.main.get_node("World/Money/Label")
@onready var payLabel = GameManager.main.get_node("World/Money/Pay")
@onready var sellLabel = GameManager.main.get_node("World/Money/Sell")
var payLabelPosition
var sellLabelPosition

func reset():
	money = 100
	updateDisplay()
	
func _ready():
	reset()
	payLabelPosition = payLabel.position
	sellLabelPosition = sellLabel.position

func pay(count):
	var paying = money > count
	if(paying): 
		money -= count
		payLabel.modulate = Color(0,0,0,1)
	else: 
		count = 0
		payLabel.modulate = Color(255,0,0,1)
	
	payLabel.text = "-" + str(int(count))
	payLabel.position = payLabelPosition
	moneyAnimation(payLabel)
	
	updateDisplay()
	
	return paying

func moneyAnimation(label):
	label.visible = true
	await TranslationManager.translate(label,label.position + Vector2(0,-100),0.5)
	label.visible = false

func addMoney(count):
	money += count
	sellLabel.text = "+" + str(int(count))
	sellLabel.position = sellLabelPosition
	
	if(count > 0): sellLabel.modulate = Color(0,0,0,1)
	else : sellLabel.modulate = Color(255,0,0,1)
	
	moneyAnimation(sellLabel)
	updateDisplay()
	
func updateDisplay():
#	print("money")
	display.text = str(int(money))
