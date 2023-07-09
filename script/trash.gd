extends Node2D

@onready var sprite = $AnimatedSprite

func trash(item):
	AudioManager.play("sounds/throw",3)
	sprite.play("open")
	if is_instance_valid(item):
		item.queue_free()
	
	await TimerManager.sleep(0.25)
	sprite.play("default")

func throw(item):
	await TranslationManager.translate(item,position,0.5)
	if (item != null) and (not item.dragging):
		trash(item)
