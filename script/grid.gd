extends Node2D

@export var cellSize = 64
@export var width = 7
@export var height = 5

var grid = []

func _ready():
	grid.resize(height)
	for i in range(height):
		grid[i] = []
		grid[i].resize(width)
		grid[i].fill(false)

## Calculate the relative position in the grid
func grid_pos(item):
	var relPos = item.position - position - Vector2(item.origin);
	relPos = relPos + Vector2(width*cellSize/2,height*cellSize/2)
	relPos = Vector2i(relPos.x / cellSize, relPos.y/cellSize)
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
