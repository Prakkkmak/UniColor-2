extends Button

signal theme_selected(theme)

export(PackedScene) var tile_scene : PackedScene


func _on_pressed():
	emit_signal("theme_selected", tile_scene)
