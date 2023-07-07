extends Node2D

@export var cellSize = 64
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
	var itemOrigin = item.position + Vector2(item.origin)
	var relPos = itemOrigin - topLeft;
	relPos = Vector2(round(relPos.x/cellSize), round(relPos.y/cellSize))
	return relPos
	
func spaces_are_free(relPos, spaces):
	for s in spaces:
		if relPos.x + s.x < 0 || relPos.x + s.x >= width:
			return false
		if relPos.y + s.y < 0 || relPos.y + s.y >= height:
			return false
		if grid[relPos.y + s.y][relPos.x + s.x]:
			return false
	return true
	
func can_be_placed(item):
	return spaces_are_free(grid_pos(item), item.spaces)
	
func place(item):
	var relPos = grid_pos(item)
	if spaces_are_free(relPos, item.spaces):
		for s in item.spaces:
			grid[relPos.y + s.y][relPos.x + s.x] = true
		current_items.append(item)
		return topLeft - Vector2(item.origin) + Vector2(relPos) * cellSize
	return null

func remove(item):
	if current_items.has(item):
		var relPos = grid_pos(item)
		for s in item.spaces:
			grid[relPos.y + s.y][relPos.x + s.x] = false
		current_items.erase(item)
