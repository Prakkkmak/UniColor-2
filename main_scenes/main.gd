extends Node2D
const scene = preload("res://main_scenes/game.tscn")

func _on_play():
	var game = scene.instance()
	var game_preview = $Menu/GamePreview
	remove_child($Menu)
	game.grid_size = game_preview.grid_size
	game.difficulty = game_preview.difficulty
	game.level_type = game_preview.level_type
	add_child(game)
