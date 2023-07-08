extends Node

@onready var buyer = $Buyer
@onready var item = $Buyer/Bubble/Item

var enabled = false

var size
var type

func newBuyer():
	if(enabled): disatifyBuyer()
	var buyerSprite = randi_range(1,5)
	buyer.play(str(buyerSprite))
	
	size = randi_range(1,3)
	type = randi_range(1,3)
	
	var itemSprite
	
	match size:
		1: itemSprite = "green"
		2: itemSprite = "blue"
		3: itemSprite = "red"
	
	match type:
		1: itemSprite += "Armor"
		2: itemSprite += "Potion"
		3: itemSprite += "Sword"
	
	item.play(itemSprite)
	
	buyer.visible = true
	
	enabled = true
	
func sell(item):
	if(item.size == size && item.type == type):
		MoneyManager.addMoney(item.getPrice()*2)
	else:
		disatifyBuyer()
	item.queue_free()
	
func removeBuyer():
	enabled = false
	buyer.visible = false
	
func disatifyBuyer():
	HealthManager.damage()
	removeBuyer()
	
