extends Node2D
const GAME = preload("res://main_scenes/game/game.tscn")
const MENU = preload("res://main_scenes/menu/menu.tscn")

onready var menu = $Menu

func _input(ev : InputEvent):
	if ev is InputEventKey and ev.is_action_pressed("escape"):
		quit_to_main_menu()

func _on_play() -> void:
	var game = GAME.instance()
	var game_preview = menu.get_node("GamePreview")
	remove_child(menu)
	game.grid_size = game_preview.grid_size
	game.difficulty = game_preview.difficulty
	game.level_type = game_preview.level_type
	game.tile_scene = game_preview.tile_scene
	add_child(game)

func quit_to_main_menu() -> void:
	remove_child($Game)
	add_child(menu)
