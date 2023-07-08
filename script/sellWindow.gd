extends Node

@onready var buyTable = get_node("../BuyTable")
@onready var buyer = $Buyer
@onready var item = $Buyer/Bubble/Item

var enabled = false

var size
var type

func pickInTable(r):
	var c = 0
	for i in range(0,3):
		for j in range(0,3):
			c = c + buyTable.receivedItems[i][j]
			if c >= r:
				size = i + 1
				type = j + 1
				return

func newBuyer():
	if(enabled): disatifyBuyer()
	var buyerSprite = randi_range(1,5)
	buyer.play(str(buyerSprite))
	
	var totalReceived = buyTable.count_received()
	var r = randi_range(0,totalReceived-1)
	pickInTable(r)
	
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
		MoneyManager.addMoney(0)
		disatifyBuyer()
	item.queue_free()
	removeBuyer()	
	
func removeBuyer():
	enabled = false
	buyer.visible = false
	
func disatifyBuyer():
	HealthManager.damage()
