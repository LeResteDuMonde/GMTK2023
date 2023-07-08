extends Node
	
@onready var ui = get_tree().root.get_node("Main/Titles")
@onready var titleScreen = ui.get_node("Title")
@onready var gameOverScreen  = ui.get_node("GameOver")
#@onready var controlScreen = ui.get_node("ControlScreen")
#@onready var destructScreen = ui.get_node("DestructScreen")
#@onready var endScreen = ui.get_node("EndScreen")
#
func _ready():
	# Show Title Screen first
	showTitleScreen()

func showTitleScreen():
	print("Show Title Screen")
	AudioManager.start_game_music()
	titleScreen.visible = true

func showGameOverScreen():
	print("Show Game Over Screen")
	gameOverScreen.visible = true
	gameOverScreen.get_node("Label").text = str(MoneyManager.money)
	
#func showLevelSelect():
#	levelSelectScreen.visible = true
#
#func showControlScreen():
#	controlScreen.visible = true
#
#func showDestructScreen():
#	print("Show Destruct Screen")
#	destructScreen.visible = true
#
#func showEndScreen(winner):
#	endScreen.visible = true
#	if winner == 1:
#		endScreen.get_node("Player1").visible = true
#	elif winner == 2:
#		endScreen.get_node("Player2").visible = true
#	else:
#		endScreen.get_node("Death").visible = true
#
#@onready var player1Interstice = ui.get_node("Player1Interstice")
#@onready var player2Interstice = ui.get_node("Player2Interstice")
#
#func showIntersticeScreen(player):
#	print("show Interstice Screen for ", player)
#	if player==1:
#		player1Interstice.visible = true
#	elif player==2:
#		player2Interstice.visible = true
#
func hideTitleScreens():
	titleScreen.visible = false
	gameOverScreen.visible = false
#	controlScreen.visible = false
#	destructScreen.visible = false
#	endScreen.visible = false
#	player1Interstice.visible = false
#	player2Interstice.visible = false
#	levelSelectScreen.visible = false
#	endScreen.get_node("Player1").visible = false
#	endScreen.get_node("Player2").visible = false
#	endScreen.get_node("Death").visible = false
#
func _input(event):
	if event.is_action_pressed("click"):
		if titleScreen.visible:
			hideTitleScreens()
			GameManager.start()
		if gameOverScreen.visible:
			hideTitleScreens()
			showTitleScreen()
			
	if(event.is_action_pressed("escape")):
		if titleScreen.visible:
			get_tree().quit()
		else:
			GameManager.stop()
			hideTitleScreens()
			showTitleScreen()
			
#			CursorManager.spawnCursor()
#		elif controlScreen.visible or player1Interstice.visible or player2Interstice.visible:
#			hideTitleScreens()
#			GameManager.startPlayPhase()
#		elif destructScreen.visible:
#			hideTitleScreens()
#			GameManager.startDeletePhase()
