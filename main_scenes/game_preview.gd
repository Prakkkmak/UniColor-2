extends "res://main_scenes/game.gd"

export(float) var tick_rate : float = 0.5
export(float) var chance_to_play : float = 0.33

var t : float = -2.0
var last_sec : float = 0.0

func _process(delta):
	t += delta
	if( t > last_sec):
		preview()
		last_sec += tick_rate

func preview():
	if(randf() < chance_to_play):
		var x = randi() % grid_size
		var y = randi() % grid_size
		_on_tile_clicked(x, y)

func fix_camera():
	$Camera2D.offset = Vector2(grid_size * tile_size / 3 - (tile_size/2), grid_size * tile_size / 2 - (tile_size/2))
	$Camera2D.zoom = Vector2(grid_size * 0.9, grid_size * 0.9)
