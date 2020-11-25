extends Button

signal level_selected(grid_size, difficulty, level_type)

enum LEVEL_TYPE {DEFAULT, SQUARE, SQUARE2, SQUARE3, DIAG}

export(int) var grid_size : int = 5 #Size of the grid
export(int) var difficulty = 2
export(LEVEL_TYPE) var level_type = LEVEL_TYPE.DEFAULT


func _on_pressed():
	emit_signal("level_selected",grid_size, difficulty, level_type)
