extends Node2D

var currentItem
#var item_r = preload("res://scenes/items/Tetromino.tscn")
var items = []

var receivedItems = []

func reset():
	currentItem = null
	receivedItems = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
	
func _ready():
	loadItems("res://scenes/items/")
#	print(items)
	reset()
	
func loadItems(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
#			if dir.current_is_dir():
#				print("Found directory: " + file_name)
#			else:
#				print("Found file: " + file_name)
			if '.remap' in file_name: # for export
				file_name = file_name.trim_suffix('.remap')
			items.push_back(load(path + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
func take():
	currentItem = null

func addItem():
#	print("newItem")
	var item = items.pick_random().instantiate()
	
	if(!MoneyManager.pay(item.getPrice())): return
	
	item.position = position + Vector2(-500,0)
	TranslationManager.translate(item,position,0.5)
	GameManager.main.get_node("World/Items").add_child(item)
	
	if(currentItem != null): 
		currentItem.get_node("Area2D").queue_free()
		GameManager.main.get_node("World/Trash").throw(currentItem)
		
	currentItem = item
	receivedItems[item.size - 1][item.type - 1] = receivedItems[item.size - 1][item.type - 1] + 1

func count_received():
	var nb = 0
	for i in range(3):
		for j in range(3):
			nb = nb + receivedItems[i][j]
	return nb
