extends Node2D

enum LEVEL_TYPE {DEFAULT, SQUARE, SQUARE2, DIAG}

export(PackedScene) var tile_scene : PackedScene
export(int) var grid_size : int = 5 #Size of the grid
export(int) var randomize_strength = 100 #Number of tiles the grid is shuffled
export(int) var difficulty = 2
export(LEVEL_TYPE) var level_type = LEVEL_TYPE.DEFAULT

var game_started : bool = false
var tile_size : int = 512

var grid = []

func _ready():
	_on_load_game()

func _on_load_game():
	tile_size = tile_scene.instance().get_node("Sprite").texture.get_size().x
	generate_grid(grid_size, grid_size)

func _on_tile_clicked(x: int, y: int):
	print(str(x) + ":" + str(y))
	for i in range(grid_size):
		for j in range(grid_size):
			if(tile_check(x,y,i,j)):
				if(game_started):
					grid[i][j].next_state()
					check_victory()
				else:
					grid[i][j].next_state_index()
					grid[i][j].set_state_properties()

func _on_set_level(new_grid_size, new_difficulty, new_level_type):
	for i in range(grid_size):
		for j in range(grid_size):
			remove_child(grid[i][j])
			grid[i][j].queue_free()
	grid_size = new_grid_size
	difficulty = new_difficulty
	level_type = new_level_type
	_on_load_game()

func generate_grid(size_x : int, size_y : int):
	game_started = false
	grid = []
	for x in range(size_x):
		grid.append([])
		grid[x]=[]
		for y in range(size_y):
			grid[x].append([])
			grid[x][y] = generate_tile(x,y)
	randomize_grid()
	fix_camera()
	game_started = true

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

func tile_check(x : int, y : int, i : int, j : int):
	if(level_type == LEVEL_TYPE.DEFAULT):
		return i == x || j == y
	elif(level_type == LEVEL_TYPE.SQUARE):
		#return i >= x - 1 && i <= x + 1 && j >= y - 1 && j <= y + 1 
		return abs(i-x) <= 1 && abs(j-y) <=1
	elif(level_type == LEVEL_TYPE.DIAG):
		return abs(i - x) == abs(j - y)
	elif(level_type == LEVEL_TYPE.SQUARE2):
		return abs(i - x) <= 1 && abs( j - y ) <= 1 && !(x == i && y == j)
	return false


func check_victory():
	var last_state = grid[0][0].state
	for i in range(grid_size):
		for j in range(grid_size):
			if(grid[i][j].state != last_state):
				return
	victory()

func victory():
	get_tree().reload_current_scene()
