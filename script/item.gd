extends Node2D

@export var spaces: Array[Vector2] = []

# Offset of the top left corner of square (0,0)
@export var origin: Vector2i = Vector2i(0,0)

@onready var highlight = get_node("Highlight")
@onready var area = get_node("Area2D")
@onready var tableSprite = $TableSprite
@onready var tableSpriteHighLight = $TableSpriteHighlight
@onready var sprite = $Sprite2D

var entered = false
var dragging = false

var onTable = true

var red_color = Color(1.0, 0.0, 0.0)
var green_color = Color(0.0, 1.0, 0.0)
var white_color = Color(1.0, 1.0, 1.0)

@export var size = 1
@export var type = 1

func getPrice():
	match size:
		1: return 10
		2: return 20
		3: return 25

func _ready():
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
		CursorManager.play("open")
		if(onTable): tableSpriteHighLight.visible = true
		else: highlight.visible = true
			
func _on_mouse_exited():
	CursorManager.play("default")
	entered = false
	if highlight != null:
		tableSpriteHighLight.visible = false
		highlight.visible = false
		
func can_place():
	var areas = area.get_overlapping_areas()
	for area in areas:
		var parent = area.get_node("../")
		if parent.name == "BuyTable" || (parent.name == "SellWindow" && parent.enabled) || parent.name == "Trash":
			return true
		if parent.name == "Stock":
			return parent.can_be_placed(self)
	return false
			
func take():
	var areas = area.get_overlapping_areas()
	for area in areas:
		var parent = area.get_node("../")
		if parent.name == "BuyTable":
			parent.take()
		if parent.name == "SellWindow":
			pass # TODO
		if parent.name == "Stock":
			parent.remove(self)
	CursorManager.play("hold")
	tableSprite.visible = false
	tableSpriteHighLight.visible = false
	sprite.visible = true
	onTable = false
	
func place():
	var areas = area.get_overlapping_areas()
	for area in areas:
		var parent = area.get_node("../")
		if parent.name == "BuyTable":
			return parent.position
		if parent.name == "SellWindow" && parent.enabled:
			parent.sell(self)
			return parent.position
		if parent.name == "Trash":
			parent.trash(self)
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
	if event.is_action_released("rotate_left") and dragging:
		rotation_degrees -= 90
	if event.is_action_released("rotate_right") and dragging:
		rotation_degrees += 90

func get_origin():
	return position + Vector2(origin).rotated(rotation)
#
#func _draw():
#	draw_rect(Rect2(get_origin(), Vector2(5,5)), Color(1,0,0))
