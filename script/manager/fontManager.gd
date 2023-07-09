extends Node

var fontTimer = 0
var fontTime = 0.5

@onready var labelSettings = preload("res://font/label.tres")
@onready var font1 = preload("res://font/gmtk2023font1-Regular.ttf")
@onready var font2 = preload("res://font/gmtk2023font2-Regular.ttf")

var isDefault = true

func _process(delta):
	fontTimer -= delta
	if(fontTimer < 0):
		fontTimer = fontTime
		changeFont()
		
func changeFont():
	labelSettings.font = font2 if isDefault else font1
	isDefault = !isDefault
