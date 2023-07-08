extends Node2D

@onready var sprite = $AnimatedSprite

func trash(item):
	sprite.play("open")
	if not item.is_queued_for_deletion():
		item.call_deferred("free")

func throw(item):
	await TranslationManager.translate(item,position,0.5)
	trash(item)
