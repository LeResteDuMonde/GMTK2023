extends Node2D

@export var spaces: Array[Vector2] = []

# Offset of the top left corner of square (0,0)
@export var origin: Vector2i = Vector2i(0,0)

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
		if can_place():
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
		
func can_place():
	var areas = area.get_overlapping_areas()
	for area in areas:
		var parent = area.get_node("../")
		if parent.name == "BuyTable" || parent.name == "SellTable" || parent.name == "Trash":
			return true
		if parent.name == "Stock":
			return parent.can_be_placed(self)
	return false
			
func take():
	var areas = area.get_overlapping_areas()
	for area in areas:
		var parent = area.get_node("../")
		if parent.name == "BuyTable":
			pass # TODO
		if parent.name == "SellTable":
			pass # TODO
		if parent.name == "Stock":
			parent.remove(self)
	
func place():
	var areas = area.get_overlapping_areas()
	for area in areas:
		var parent = area.get_node("../")
		if parent.name == "BuyTable":
			return parent.position
		if parent.name == "SellTable":
			return parent.position
		if parent.name == "Trash":
			queue_free()
		if parent.name == "Stock":
			return parent.place(self)
	# Otherwise, no !
	return null

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not dragging and entered:
			take()
			move_to_front()
			get_viewport().set_input_as_handled()
			dragging = true
		elif dragging:
			var releasedpos = place()
			if releasedpos:
				dragging = false
				self.position = releasedpos
			get_viewport().set_input_as_handled()
