extends Node2D

@onready var sprite = $AnimatedSprite

func trash(item):
	await TranslationManager.translate(item,position,0.5)
	sprite.play("open")
	item.queue_free()
#	print("trash")
