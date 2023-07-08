extends Node2D

@export var cellSize = 128
@export var cells: Array[Vector2] = []

# Offset of the top left corner of square (0,0)
# @export var origin: Vector2i = Vector2i(0,0)

@onready var highlight = get_node("Highlight")
@onready var area = get_node("Area2D")
@onready var tableSprite = $TableSprite
@onready var tableSpriteHighLight = $TableSpriteHighlight
@onready var sprite = $Sprite2D

var entered = false

var onTable = true

var red_color = Color(1.0, 0.0, 0.0)
var green_color = Color(0.0, 1.0, 0.0)
var white_color = Color(1.0, 1.0, 1.0)

@export var size = 1
@export var type = 1

var dragging = false

func getPrice():
	match size:
		1: return 10
		2: return 20
		3: return 25

func _ready():
	get_node("Sprite2D").visible = false
	highlight.material = highlight.material.duplicate()
	
	var itemSprite
	
	match size:
		1: itemSprite = "green"
		2: itemSprite = "blue"
		3: itemSprite = "red"
	
	match type:
		1: itemSprite += "Armor"
		2: itemSprite += "Potion"
		3: itemSprite += "Sword"
	
	tableSprite.play(itemSprite)
	tableSpriteHighLight.play(itemSprite)
	
func _process(delta):
	var shader_color
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.global_position = Vector2(mousepos.x, mousepos.y)
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
		CursorManager.hover()
		if(onTable): tableSpriteHighLight.visible = true
		else: highlight.visible = true
			
func _on_mouse_exited():
	CursorManager.unhover()
	entered = false
	if highlight != null:
		tableSpriteHighLight.visible = false
		highlight.visible = false
		
func can_place():
	if not is_instance_valid(area): return
	var areas = area.get_overlapping_areas()
	for area in areas:
		var parent = area.get_node("../")
		if (parent.name == "SellWindow" && parent.enabled) || parent.name == "Trash":
			return true
		if parent.name == "Stock":
			return parent.can_be_placed(self)
	return false
			
func take():
	if(not is_instance_valid(area)): return
	var areas = area.get_overlapping_areas()
	for area in areas:
		var parent = area.get_node("../")
		if parent.name == "BuyTable":
			parent.take()
		if parent.name == "Stock":
			parent.remove(self)
	CursorManager.take()
	tableSprite.visible = false
	tableSpriteHighLight.visible = false
	sprite.visible = true
	highlight.visible = true
	onTable = false
	
func place():
	var areas = area.get_overlapping_areas()
	for area in areas:
		var parent = area.get_node("../")
		if parent.name == "SellWindow" && parent.enabled:
			CursorManager.release()
			parent.sell(self)
			position = parent.position
		if parent.name == "Trash":
			CursorManager.release()
			parent.trash(self)
		if parent.name == "Stock":
			CursorManager.release_hover()
			position = parent.place(self)
			
			var soundType
			match type:
				1: soundType = "Armor"
				2: soundType = "Potion"
				3: soundType = "Sword"
			
			AudioManager.play("sounds/deposit"+soundType)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not CursorManager.dragging and entered:
			dragging = true	
			take()
			move_to_front()
			get_viewport().set_input_as_handled()
		elif dragging:
			if can_place():
				dragging = false
				place()
			else:
				AudioManager.play("sounds/cantPlace")
			get_viewport().set_input_as_handled()
	if event.is_action_released("rotate_left") and dragging:
		AudioManager.play("sounds/rotate")
		rotation_degrees -= 90
	if event.is_action_released("rotate_right") and dragging:
		AudioManager.play("sounds/rotate")
		rotation_degrees += 90

@export var offset = Vector2(0,0)
	
# Get cells after rotate
func get_rotated_cells():
	return cells.map(func(v):
		v = (v + offset).rotated(rotation) - get_rotated_offset()
		return Vector2i(round(v.x), round(v.y)))
		
func get_rotated_offset():
	return offset.rotated(rotation)
