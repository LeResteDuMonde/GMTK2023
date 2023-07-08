extends Node2D

@onready var sprite = $AnimatedSprite

func trash(item):
	sprite.play("open")
	item.call_deferred("free")

func throw(item):
	await TranslationManager.translate(item,position,0.5)
	trash(item)
