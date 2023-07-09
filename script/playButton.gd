extends Sprite2D

var onSprite = preload("res://sprite/playButton/playButton.png")
var offSprite = preload("res://sprite/playButton/playButton.png")

func _on_area_2d_mouse_entered():
	AudioManager.play("sounds/select",1,-5)
	texture = onSprite


func _on_area_2d_mouse_exited():
	texture = offSprite
