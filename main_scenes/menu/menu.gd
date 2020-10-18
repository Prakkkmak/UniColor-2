extends Node2D

signal start_game

func open_levels_menu():
	$Canvas/MarginContainer/HBoxContainer/Menu.hide()
	$Canvas/MarginContainer/HBoxContainer/Levels.show()


func _on_play():
	emit_signal("start_game")
