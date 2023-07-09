extends Sprite2D

@onready var credits = $CreditBackground

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_mouse_entered():
	credits.visible = true


func _on_area_2d_mouse_exited():
	credits.visible = false
