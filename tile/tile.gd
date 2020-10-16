extends Node2D

class_name Tile

signal tile_clicked(x,y)

export(Array, Color) var states : Array = []
export(int) var max_states : int = 2
export(String) var anim : String = "swap"

var state = 0

var x = 0
var y = 0

var sprite : Sprite 

func _ready():
	if(max_states > len(states)):
		push_error("Not enough states for this max_states")
	sprite = $Sprite
	next_state()

func next_state():
	next_state_index()
	$AnimationPlayer.stop()
	$AnimationPlayer.play(anim)

func set_state_properties():
	$Sprite.modulate = states[state]

func next_state_index():
	state += 1
	if max_states <= state:
		state = 0
	$State.text = str(state)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			emit_signal("tile_clicked", x, y)
