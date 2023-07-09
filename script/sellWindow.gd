extends Node

@onready var buyTable = get_node("../BuyTable")
@onready var buyer = $Buyer
@onready var item = $Buyer/Bubble/Item

var enabled = false
var buyerSprite

var size
var type

var sellingPrice = 1

func _process(delta):
	sellingPrice += delta / 45

func pickInTable(r):
	var c = 0
	for i in range(0,3):
		for j in range(0,3):
			c = c + buyTable.receivedItems[i][j]
			if c > r:
				size = i + 1
				type = j + 1
				return

func newBuyer():
	if(enabled): 
		disatifyBuyer()
		await TimerManager.sleep(0.5)
	buyerSprite = randi_range(1,5)
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
	
	buyTable.receivedItems[size-1][type-1] -= 1 
	item.play(itemSprite)
	AudioManager.play("sounds/appear",2)
	
	buyer.visible = true
	enabled = true
	
func sell(item):
	if(item.size == size && item.type == type):
		AudioManager.play("sounds/sell")
		MoneyManager.addMoney(item.getPrice()*sellingPrice)
	else:
		MoneyManager.addMoney(0)
		disatifyBuyer()
	item.queue_free()
	removeBuyer()	
	
func removeBuyer():
	enabled = false
	buyer.visible = false
	
func disatifyBuyer():
	buyer.play(str(buyerSprite) + "angry")
	ShakeManager.shake(3,0.2)
	AudioManager.play("sounds/disatisfied",3)
	HealthManager.damage()
