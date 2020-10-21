extends Node2D

signal start_game

### Levels Menu ###
func open_levels_menu():
	$Canvas/MarginContainer/HBoxContainer/Menu.hide()
	$Canvas/MarginContainer/HBoxContainer/Levels.show()

func open_themes_menu():
	$Canvas/MarginContainer/HBoxContainer/Menu.hide()
	$Canvas/MarginContainer/HBoxContainer/Themes.show()

func open_main_menu():
	$Canvas/MarginContainer/HBoxContainer/Themes.hide()
	$Canvas/MarginContainer/HBoxContainer/Levels.hide()
	$Canvas/MarginContainer/HBoxContainer/Menu.show()

func _on_play():
	emit_signal("start_game")


func _on_exit_pressed():
	get_tree().quit()


