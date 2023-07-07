extends Node

var buyerTimer
var buyerTime = 1
var sellerTimer
var sellerTime = 2

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
		# TODO new seller
	
	buyerTimer -= delta
	sellerTimer -= delta
	
	if(buyerTime > BUYER_TIME_MIN):
		buyerTime = buyerTime * 0.9999
#		print(buyerTime)
	
func start():
	buyerTime = BUYER_TIME_DEFAULT
	buyerTimer = buyerTime
	sellerTimer = sellerTime
	running = true
	
func stop():
	running = false
