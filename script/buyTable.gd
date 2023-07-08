extends Node2D

var currentItem
#var item_r = preload("res://scenes/items/Tetromino.tscn")
var items = []

func reset():
	currentItem = null
	
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
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
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
	
	MoneyManager.pay(item.getPrice())
	
	item.position = position
	GameManager.main.get_node("World/Items").add_child(item)
	
	if(currentItem != null): 
		currentItem.get_node("Area2D").queue_free()
		GameManager.main.get_node("World/Trash").throw(currentItem)
		
	currentItem = item
