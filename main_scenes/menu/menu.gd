extends Node2D
const scene = preload("res://main_scenes/game.tscn")

func _on_play():
	var game = scene.instance()
	var game_preview = $Game
	remove_child($CanvasLayer)
	remove_child(game_preview)
	game.grid_size = game_preview.grid_size
	game.difficulty = game_preview.difficulty
	game.level_type = game_preview.level_type
	add_child(game)
