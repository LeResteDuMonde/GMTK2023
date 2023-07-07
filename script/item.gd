extends Node2D

@onready var highlight = get_node("Highlight")

var entered = false
var dragging = false

func _process(delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.global_position = Vector2(mousepos.x, mousepos.y)

func _on_mouse_entered():
	entered = true
	if highlight != null:
		highlight.visible = true
		
func _on_mouse_exited():
	entered = false
	if highlight != null:
		highlight.visible = false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if entered and event.pressed:
			dragging = true
		if dragging and not event.pressed:
			dragging = false
