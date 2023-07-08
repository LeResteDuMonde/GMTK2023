extends Node

@onready var root = get_tree().root
@onready var main = root.get_node("Main")
@onready var world = main.get_node("World")
@onready var items = world.get_node("Items")
@onready var stock = world.get_node("Stock")
@onready var buyTable = world.get_node("BuyTable")
@onready var sellWindow = world.get_node("SellWindow")

var web
#var main_r = preload("res://scenes/Main.tscn")

func _ready():
	if(OS.get_distribution_name() == ""): web = true
	root = get_tree().root
#	TimerManager.start()
#	AudioManager.play("sounds/hit")
	
func start():
	TimerManager.start()
	
func stop():
	# Destroy all items
	for i in items.get_children():
		if i: i.call_deferred("free")
	# Reset table and buyer
	buyTable.reset()
	sellWindow.removeBuyer()
	# Reset the grid
	stock.reset()
	# Reset money and health
	MoneyManager.reset()
	HealthManager.reset()
	# Reset timer
	TimerManager.stop()

func gameOver():
	stop()
	TitleManager.showGameOverScreen()
	
func quit():
	stop()
	TitleManager.displayTitleScreen()
