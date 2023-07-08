extends Node2D

@export var cellSize = 128
@export var width = 7
@export var height = 5

@onready var topLeft = position - Vector2(width*cellSize/2,height*cellSize/2)

var grid = []
var current_items = []

func _ready():
	grid.resize(height)
	for i in range(height):
		grid[i] = []
		grid[i].resize(width)
		grid[i].fill(false)


## Calculate the relative position in the grid
func grid_pos(item):
	var offset = item.offset * cellSize
	var relPos = item.position - topLeft + offset
	relPos = Vector2i(round(relPos.x/cellSize + item.offset.x), round(relPos.y/cellSize + item.offset.y))
	return relPos
	
func cells_are_free(relPos, item):
	print("cells_are_free")
	for s in item.get_rotated_cells():
		var cellPos = Vector2i(relPos) + s
		print(cellPos)
		if cellPos.x < 0 || cellPos.x >= width:
			print("bad x")
			return false
		if cellPos.y < 0 || cellPos.y >= height:
			print("bad y")
			return false
		if grid[cellPos.y][cellPos.x]:
			print("busy")
			return false
	print("ok")
	return true
	
func can_be_placed(item):
	return cells_are_free(grid_pos(item), item)
	
func place(item):
	var relPos = grid_pos(item)
	var offset = item.offset * cellSize
	if cells_are_free(relPos, item):
		#print("place")
		for s in item.get_rotated_cells():
			var cellPos = Vector2i(relPos) + s
			#print(cellPos)	
			grid[cellPos.y][cellPos.x] = true
		current_items.append(item)
		return topLeft - offset + Vector2(relPos) * cellSize + Vector2(cellSize/2,cellSize/2)
	return null

func remove(item):
	if current_items.has(item):
		var relPos = grid_pos(item)
		for s in item.get_rotated_cells():
			grid[relPos.y + s.y][relPos.x + s.x] = false
		current_items.erase(item)
