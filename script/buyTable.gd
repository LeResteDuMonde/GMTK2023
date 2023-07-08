extends Node2D

var currentItem
var item_r = preload("res://scenes/items/Tetromino.tscn")

func addItem():
#	print("newItem")
	var item = item_r.instantiate()
	
	MoneyManager.pay(item.getPrice())
	
	item.position = position
	GameManager.main.get_node("World/Items").add_child(item)
	
	if(currentItem != null): 
		if(currentItem.position == position):
			GameManager.main.get_node("World/Trash").throw(currentItem)
		
	currentItem = item
