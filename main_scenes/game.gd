extends Node2D

export(PackedScene) var tile_scene : PackedScene = preload("res://tile/tile.tscn")
export(int) var grid_size : int = 5 #Size of the grid
export(int) var randomize_strength = 100 #Number of tiles the grid is shuffled
export(int) var difficulty = 2
export(bool) var is_preview = false

var tile_size = 1

const grid = []

func _ready():
	tile_size = tile_scene.instance().get_node("Sprite").texture.get_size().x
	generate_grid(grid_size, grid_size)

func generate_grid(size_x : int, size_y : int):
	for x in range(size_x):
		grid.append([])
		grid[x]=[]
		for y in range(size_y):
			grid[x].append([])
			grid[x][y] = generate_tile(x,y)
	randomize_grid()
	fix_camera()

func randomize_grid():
	for i in range(randomize_strength):
		var x = randi() % grid_size
		var y = randi() % grid_size
		_on_tile_clicked(x, y)

func fix_camera():
	$Camera2D.offset = Vector2(grid_size * tile_size / 2 - (tile_size/2), grid_size * tile_size / 2 - (tile_size/2))
	$Camera2D.zoom = Vector2(grid_size, grid_size)

func generate_tile(x : int, y : int) -> Tile:
	var tile : Tile = tile_scene.instance()
	add_child(tile)
	tile.x = x
	tile.y = y
	tile.connect("tile_clicked", self, "_on_tile_clicked")
	var tile_size = tile.get_node("Sprite").texture.get_size().x
	tile.position = Vector2(x * tile_size, y * tile_size)
	tile.max_states = difficulty
	return tile

func _on_tile_clicked(x: int, y: int):
	for i in range(grid_size):
		for j in range(grid_size):
			if(i == x || j == y):
				grid[i][j].next_state()

