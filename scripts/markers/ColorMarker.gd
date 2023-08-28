extends ColorRect
class_name ColorMarker

@export var circle_color: Color
@export var cross_color: Color
@export var free_cell_color: Color

var color_map = {}

# Changes cell state. It is assumed that there is two players with certain ids.
func change_cell_state(player_identifier: String):
	var new_state: Color = color_map[player_identifier]
	if (new_state == null):
		push_warning("State of Color Marker is null")
	self.color = new_state


func set_free_cell():
	self.color = free_cell_color


# Called when the node enters the scene tree for the first time.
func _ready():
	self.color = free_cell_color
	color_map = {
		Cell.CROSS_IDENTIFIER: cross_color,
		Cell.CIRCLE_IDENTIFIER: circle_color
	}
