extends Node2D

func trash(item):
	await TranslationManager.translate(item,position,0.5)
	item.queue_free()
#	print("trash")
