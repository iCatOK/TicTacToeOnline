extends Control
class_name Cell

@export var row: int = 0
@export var col: int = 0

@onready var marker = $TextureMarker

var is_occupied: bool = false

signal cell_ocuppied(cell: Cell)


func change_cell_state(player_identifier: String):
	is_occupied = true
	marker.change_cell_state(player_identifier)
	

func reset_cell():
	is_occupied = false
	marker.set_free_cell()


# Emmit signal and set itself if pressed
func _on_gui_input(event: InputEvent):
	if event.is_action_pressed("ui_left_click"):
		emit_signal("cell_ocuppied", self)
		
