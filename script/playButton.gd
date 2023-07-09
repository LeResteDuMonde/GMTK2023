extends Sprite2D

var onSprite = preload("res://sprite/playButton/playButton2.png")
var offSprite = preload("res://sprite/playButton/playButton.png")

func _on_area_2d_mouse_entered():
	AudioManager.play("sounds/select",1,-5)
	texture = onSprite
	scale = Vector2(1.05,1.05)


func _on_area_2d_mouse_exited():
	texture = offSprite
	scale = Vector2(1,1)
