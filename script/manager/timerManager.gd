extends Node

var buyerTimer
var buyerTime = 10
var sellerTimer 
var sellerTime = 6

var buyerTimerBar
var sellerTimerBar

const BUYER_TIME_DEFAULT = 14
const BUYER_TIME_MIN = 4.5

const SELLER_TIME_DEFAULT = 6
const SELLER_TIME_MIN = 1.5

const ACCELERATION = 0.9999

var running = false

func _process(delta):
	if(!running): return
	
	if(buyerTimer <= 0):
		buyerTimer = buyerTime
		GameManager.main.get_node("World/SellWindow").newBuyer()
		
	if(sellerTimer <= 0):
		sellerTimer = sellerTime
		GameManager.main.get_node("World/BuyTable").addItem()
	
	buyerTimer -= delta
	sellerTimer -= delta
	
	buyerTimerBar.scale.x = buyerTimer / buyerTime
	sellerTimerBar.scale.x = sellerTimer / sellerTime
	
	if(buyerTime > BUYER_TIME_MIN):
		buyerTime *= ACCELERATION
		AudioManager.set_music_speed(BUYER_TIME_DEFAULT/buyerTime)
#		print(buyerTime)
	
	if(sellerTime > SELLER_TIME_MIN):
		sellerTime *= ACCELERATION
	
func start():
	buyerTime = BUYER_TIME_DEFAULT
	sellerTime = SELLER_TIME_DEFAULT
	
	buyerTimerBar = GameManager.main.get_node("World/SellWindow/TimerBar")
	sellerTimerBar = GameManager.main.get_node("World/BuyTable/Timer/BarScale/TimerBar")
	
	running = true
	
	buyerTimer = 1
	sellerTimer = 0.5
	
func sleep(time):
	await get_tree().create_timer(time).timeout
	return
	
func stop():
	running = false
