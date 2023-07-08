extends Node2D

@export var cellSize = 128
@export var width = 7
@export var height = 5

@onready var topLeft = position - Vector2(width*cellSize/2,height*cellSize/2)

@onready var highlights = $Highlights
	
var grid = []
var current_items = []

func reset():
	grid.resize(height)
	for i in range(height):
		grid[i] = []
		grid[i].resize(width)
		grid[i].fill(false)
	current_items = []
	un_highlight()
		
func _ready():
	reset()

var highlightOk = preload("res://scenes/world/HighlightCellOk.tscn")
var highlightErr = preload("res://scenes/world/HighlightCellErr.tscn")

## Highlight (in yellow) a cell
func highlight(x, y, scene):
	var hl = scene.instantiate()
	highlights.add_child(hl)
	hl.position = Vector2(x, y) * cellSize - Vector2(width*cellSize/2,height*cellSize/2) + Vector2(cellSize/2,cellSize/2)
	
func un_highlight():
	for n in highlights.get_children():
		print(n)
		n.visible = false
		n.call_deferred("free")

## Calculate the relative position in the grid
func grid_pos(item):
	var offset = item.get_rotated_offset()
	var relPos = item.position - topLeft - Vector2(cellSize/2,cellSize/2)
	relPos = Vector2i(round(relPos.x/cellSize + offset.x), round(relPos.y/cellSize + offset.y))
	return relPos
	
func cells_are_free(relPos, item):
	#print("cells_are_free")
	un_highlight()
	var allOk = true
	for s in item.get_rotated_cells():
		var cellPos = Vector2i(relPos) + s
		if cellPos.x < 0 || cellPos.x >= width:
			allOk = false
		elif cellPos.y < 0 || cellPos.y >= height:
			allOk = false
		elif grid[cellPos.y][cellPos.x]:
			allOk = false
			highlight(cellPos.x, cellPos.y, highlightErr)
		else:
			highlight(cellPos.x, cellPos.y, highlightOk)
	return allOk
	
func can_be_placed(item):
	return cells_are_free(grid_pos(item), item)
	
func place(item):
	var relPos = grid_pos(item)
	var offset = item.get_rotated_offset()
#	if cells_are_free(relPos, item):
	un_highlight()
	#print("place")
	for s in item.get_rotated_cells():
		var cellPos = Vector2i(relPos) + s
		#print(cellPos)	
		grid[cellPos.y][cellPos.x] = true
	current_items.append(item)
	return topLeft - offset * cellSize + Vector2(relPos) * cellSize + Vector2(cellSize/2,cellSize/2)
#	return null

func remove(item):
	if current_items.has(item):
		var relPos = grid_pos(item)
		for s in item.get_rotated_cells():
			grid[relPos.y + s.y][relPos.x + s.x] = false
		current_items.erase(item)

