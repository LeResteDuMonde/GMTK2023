extends Node

var buyerTimer
var buyerTime = 1
var sellerTimer
var sellerTime = 2

var buyerTimerBar
var sellerTimerBar

const BUYER_TIME_DEFAULT = 20
const BUYER_TIME_MIN = 5

var running = false

func _process(delta):
	if(!running): return
	
	if(buyerTimer <= 0):
		buyerTimer = buyerTime
		# TODO new buyer
		
	if(sellerTimer <= 0):
		sellerTimer = sellerTime
		GameManager.main.get_node("BuyTable").addItem()
	
	buyerTimer -= delta
	sellerTimer -= delta
	
	buyerTimerBar.scale.x = buyerTimer / buyerTime
	sellerTimerBar.scale.x = sellerTimer / sellerTime
	
	if(buyerTime > BUYER_TIME_MIN):
		buyerTime = buyerTime * 0.9999
#		print(buyerTime)
	
func start():
	buyerTime = BUYER_TIME_DEFAULT
	buyerTimer = buyerTime
	sellerTimer = sellerTime
	
	buyerTimerBar = GameManager.main.get_node("ShopWindow/TimerBar")
	sellerTimerBar = GameManager.main.get_node("Table/TimerBar")
	
	running = true
	
func sleep(time):
	await get_tree().create_timer(time).timeout
	return
	
func stop():
	running = false
