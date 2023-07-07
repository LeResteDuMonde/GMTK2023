extends Node2D

@onready var highlight = get_node("Highlight")
@onready var area = get_node("Area2D")

var entered = false
var dragging = false

var red_color = Color(1.0, 0.0, 0.0)
var green_color = Color(0.0, 1.0, 0.0)
var white_color = Color(1.0, 1.0, 1.0)

func _process(delta):
	var shader_color
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)
		if can_release():
			shader_color = green_color
		else:
			shader_color = red_color
	else:
		shader_color = white_color
	highlight.material.set_shader_parameter("line_color", shader_color)

func _on_mouse_entered():
	entered = true
	if highlight != null:
		highlight.visible = true
		
func _on_mouse_exited():
	entered = false
	if highlight != null:
		highlight.visible = false
		
func can_release():
	var areas = area.get_overlapping_areas()
	for area in areas:
		var parent = area.get_node("../")
		if parent.name == "BuyTable" || parent.name == "SellTable" || parent.name == "Trash":
			return true
	return false
			
func release():
	var areas = area.get_overlapping_areas()
	for area in areas:
		var parent = area.get_node("../")
		if parent.name == "BuyTable":
			return parent.position
		if parent.name == "SellTable":
			return parent.position
		if parent.name == "Trash":
			queue_free()
	# Otherwise, no !
	return null

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not dragging and entered:
			# Catch the object and start dragging it
			dragging = true
		elif dragging:
			var releasedpos = release()
			if releasedpos:
				dragging = false
				self.position = releasedpos
